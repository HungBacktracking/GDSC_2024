package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"golang.org/x/net/context"
	"google.golang.org/api/iterator"

	"server/bootstrap"
	"server/domain"
)

// AddTokenRequest represents the request payload for adding FCM tokens
type AddTokenRequest struct {
	UID      string `json:"uid"`
	FcmToken string `json:"fcm_token"`
}

// AddToken adds an FCM token to a user's document in Firestore
func AddToken(c echo.Context) error {
	req := new(AddTokenRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	// Connect to Firestore
	ctx := context.Background()
	collectionName := "user"
	query := bootstrap.FirestoreClient.Collection(collectionName).Where("id", "==", req.UID)

	// Get the user document
	iter := query.Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}

		// Map Firestore document to user struct
		var userDoc domain.UserInfo
		if err := doc.DataTo(&userDoc); err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}

		// Check if the fcm_tokens field exists
		if userDoc.FcmTokens == nil {
			// If the field doesn't exist, create it and add the FCM token
			userDoc.FcmTokens = []string{req.FcmToken}
		} else {
			// If the field exists, check for duplicate before adding the FCM token
			if !contains(userDoc.FcmTokens, req.FcmToken) {
				userDoc.FcmTokens = append(userDoc.FcmTokens, req.FcmToken)
			}
		}

		// Update the user document in Firestore
		if _, err := doc.Ref.Set(ctx, userDoc); err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to update FCM token"})
		}
	}

	// Return success response
	return c.NoContent(http.StatusOK)
}

// contains checks if a string exists in a slice
func contains(slice []string, value string) bool {
	for _, v := range slice {
		if v == value {
			return true
		}
	}
	return false
}
