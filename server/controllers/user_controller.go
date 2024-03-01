package controllers

import (
	"log"
	"net/http"
	"time"

	"firebase.google.com/go/auth"
	"github.com/labstack/echo/v4"

	"server/domain"

	"context"

	"server/bootstrap"

	"cloud.google.com/go/firestore"
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
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
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

type AddUserRequest struct {
	UID         string `json:"id"`
	Name        string `json:"name"`
	DisplayName string `json:"displayName"`
	IsBanned    bool   `json:"isBanned"`
	IsActive    bool   `json:"isActive"`
	IsVolunteer bool   `json:"isVolunteer"`
	PhotoURL    string `json:"photoURL"`
	PhoneNumber string `json:"phoneNumber"`
}

// AddUserResponse represents the response payload for the AddUser endpoint
type AddUserResponse struct {
	ID string `json:"uid"`
}

// AddUser adds a new user to Firebase Authentication and Firestore
func AddUser(c echo.Context) error {
	req := new(AddUserRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	// // Step 1: Create user in Firebase Authentication
	// authClient, err := bootstrap.FirebaseApp.Auth(context.Background())
	// if err != nil {
	// 	return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to get Auth client"})
	// }

	// params := (&auth.UserToCreate{}).
	// 	PhoneNumber(req.PhoneNumber).
	// 	DisplayName(req.DisplayName)

	// u, err := authClient.CreateUser(context.Background(), params)
	// if err != nil {
	// 	log.Printf("Error creating user in Authentication: %v", err)
	// 	return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to create user in Authentication"})
	// }

	// Step 2: Create user document in Firestore
	ctx := context.Background()
	collectionName := "user"
	userDoc := bootstrap.FirestoreClient.Collection(collectionName).Doc(req.UID)

	// Check if the user already exists in Firestore
	if doc, err := userDoc.Get(ctx); err == nil && doc.Exists() {
		return c.JSON(http.StatusConflict, domain.ErrorResponse{Message: "User already exists"})
	}

	// Map AddUserRequest to Firestore document
	userInfo := domain.UserInfo{
		ID:          req.UID,
		Name:        req.Name,
		IsBanned:    req.IsBanned,
		IsActive:    req.IsActive,
		IsVolunteer: req.IsVolunteer,
		CreatedAt:   time.Now(),
		Avatar:      req.PhotoURL,
	}

	// Set Firestore document with the user information
	if _, err := userDoc.Set(ctx, userInfo); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to create user in Firestore"})
	}

	// Return the user ID
	response := AddUserResponse{ID: req.UID}
	return c.JSON(http.StatusCreated, response)
}

// IsExistPhoneRequest represents the request payload for checking if a user with a phone number exists
type IsExistPhoneRequest struct {
	PhoneNumber string `json:"phone_number"`
}

// IsExistPhone checks if a user with the provided phone number exists in Firebase Authentication
func IsExistPhone(c echo.Context) error {
	req := new(IsExistPhoneRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	// Create Auth client
	authClient, err := bootstrap.FirebaseApp.Auth(context.Background())
	if err != nil {
		log.Printf("Error getting Auth client: %v", err)
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
	}

	// Check if user with phone number exists
	_, err = authClient.GetUserByPhoneNumber(context.Background(), req.PhoneNumber)
	if err != nil {
		if auth.IsUserNotFound(err) {
			// User not found, return appropriate response
			return c.JSON(http.StatusOK, map[string]bool{"exists": false})
		}

		log.Printf("Error checking user existence: %v", err)
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
	}

	// User found, return appropriate response
	return c.JSON(http.StatusOK, map[string]bool{"exists": true})
}

// UpdLocationRequest represents the request payload for updating user location
type UpdLocationRequest struct {
	UID       string  `json:"uid"`
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

// UpdLocation updates the user location in Firestore
func UpdLocation(c echo.Context) error {
	req := new(UpdLocationRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	// Get the user document
	userDoc, err := bootstrap.FirestoreClient.Collection("user").Doc(req.UID).Get(ctx)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
	}

	// Update or create the location field
	location := domain.GeoPoint{
		Lat: req.Latitude,
		Lng: req.Longitude,
	}

	updateData := map[string]interface{}{"location": location}

	if _, err := userDoc.Ref.Set(ctx, updateData, firestore.MergeAll); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to update user location"})
	}

	return c.NoContent(http.StatusOK)
}

type AddRangeRequest struct {
	UID       string  `json:"uid"`
	Radius    float64 `json:"radius"`
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

// AddRange adds latitude, longitude, and radius to the "ranges" field in Firestore
func AddRange(c echo.Context) error {
	req := new(AddRangeRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	// Get the user document
	userDoc, err := bootstrap.FirestoreClient.Collection("user").Doc(req.UID).Get(ctx)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
	}

	// Extract existing ranges or initialize a new one
	var ranges []domain.Range
	existingRanges, exists := userDoc.Data()["ranges"]
	if exists {
		// Convert existingRanges to []domain.Range
		if err := mapstructure.Decode(existingRanges, &ranges); err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}
	} else {
		ranges = make([]domain.Range, 0)
	}

	// Add the new range
	newRange := domain.Range{
		Lat:    req.Latitude,
		Lng:    req.Longitude,
		Radius: req.Radius,
	}

	ranges = append(ranges, newRange)

	// Update the ranges field in Firestore
	updateData := map[string]interface{}{"ranges": ranges}
	if _, err := userDoc.Ref.Set(ctx, updateData, firestore.MergeAll); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to update user ranges"})
	}

	return c.NoContent(http.StatusOK)
}
