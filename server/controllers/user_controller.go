package controllers

import (
	"net/http"

	"github.com/labstack/echo/v4"

	"server/domain"
)

// GetUserRequest represents the request payload for the GetUser endpoint
type GetUserRequest struct {
	UID string `json:"uid"`
}

// GetUserResponse represents the response payload for the GetUser endpoint
type GetUserResponse struct {
	UID         string `json:"uid"`
	Email       string `json:"email"`
	DisplayName string `json:"displayName"`
	PhoneNumber string `json:"phoneNumber"`
}

// GetUser retrieves user information based on the provided UID
func GetUser(c echo.Context) error {
	// req := new(GetUserRequest)
	// if err := c.Bind(req); err != nil {
	// 	return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	// }

	// app, err := bootstrap.InitializeApp()
	// if err != nil {
	// 	return c.JSON(http.StatusInternalServerError, ErrorResponse{"Failed to initialize Firebase app"})
	// }

	// ctx := context.Background()

	// client, err := firebaseApp.Auth(ctx)
	// if err != nil {
	// 	return c.JSON(http.StatusInternalServerError, ErrorResponse{"Failed to get Auth client"})
	// }

	// u, err := client.GetUser(ctx, req.UID)
	// if err != nil {
	// 	return c.JSON(http.StatusNotFound, ErrorResponse{"User not found"})
	// }

	// userInfo := GetUserResponse{
	// 	UID:         u.UID,
	// 	Email:       u.Email,
	// 	DisplayName: u.DisplayName,
	// 	PhoneNumber: u.PhoneNumber,
	// }

	return c.JSON(http.StatusOK, domain.ErrorResponse{Message: "Invalid request payload"})
}

// func getUserInfoFromFirestore(ctx context.Context, uid string) (*domain.UserInfo, error) {
// 	doc, err := bootstrap.FirebaseApp.Collection("users").Doc(uid).Get(ctx)
// 	if err != nil {
// 		return nil, err
// 	}

// 	var userInfo domain.UserInfo
// 	if err := doc.DataTo(&userInfo); err != nil {
// 		return nil, err
// 	}

// 	return &userInfo, nil
// }
