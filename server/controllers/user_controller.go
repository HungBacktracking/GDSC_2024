package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"

	"server/domain"

	"context"

	"server/bootstrap"

	"google.golang.org/api/iterator"
)

// GetUserRequest represents the request payload for the GetUser endpoint
type GetUserRequest struct {
	UID string `json:"uid"`
}

// GetUser retrieves user information based on the provided UID
func GetUser(c echo.Context) error {
	req := new(GetUserRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	client, err := bootstrap.FirebaseApp.Auth(ctx)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to get Auth client"})
	}

	u, err := client.GetUser(ctx, req.UID)
	if err != nil {
		return c.JSON(http.StatusNotFound, domain.ErrorResponse{Message: "User not found"})
	}

	// get the rest of information in firestore
	collectionName := "user"
	query := bootstrap.FirestoreClient.Collection(collectionName).Where("id", "==", req.UID)
	var firestoreUser domain.UserInfo
	iter := query.Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}

		// Map Firestore document to UserInfo struct
		var user domain.UserInfo
		if err := doc.DataTo(&user); err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}

		firestoreUser = user
	}

	userInfo := domain.GetUserResponse{
		UID:         u.UID,
		Name:        firestoreUser.Name,
		DisplayName: u.DisplayName,
		IsBanned:    firestoreUser.IsBanned,
		IsActive:    firestoreUser.IsActive,
		IsVolunteer: firestoreUser.IsVolunteer,
		CreatedAt:   firestoreUser.CreatedAt,
		Avatar:      u.PhotoURL,
		PhoneNumber: u.PhoneNumber,
	}

	return c.JSON(http.StatusOK, userInfo)
}

func GetProfile(c echo.Context) error {
	req := new(GetUserRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	collectionName := "profile"
	query := bootstrap.FirestoreClient.Collection(collectionName).Where("id", "==", req.UID)

	var userProfile domain.UserProfile

	iter := query.Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}

		// Map Firestore document to UserProfile struct
		var profile domain.UserProfile
		if err := doc.DataTo(&profile); err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}

		userProfile = profile
	}

	return c.JSON(http.StatusOK, userProfile)
}
