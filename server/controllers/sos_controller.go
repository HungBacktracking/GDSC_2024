// in controllers/controllers.go
package controllers

import (
	"context"
	"math"
	"net/http"
	"server/bootstrap"
	"server/domain"
	"server/utils"
	"strconv"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/labstack/echo/v4"
	"google.golang.org/api/iterator"
)

// CreateRoomRequest represents the request payload for the CreateRoom endpoint
type CreateRoomRequest struct {
	UID         string          `json:"uid"`
	PatientID   string          `json:"patientId"`
	EmergencyID []int           `json:"emergencyId"`
	Location    domain.GeoPoint `json:"location"`
	ImageLink   string          `json:"image_link"`
}

// CreateRoom creates a new SOS room in Firestore
func CreateRoom(c echo.Context) error {
	req := new(CreateRoomRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	// Auto-increment room ID
	roomID, err := getNewRoomID(ctx)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to get new room ID"})
	}

	// Create Room document
	room := domain.Room{
		ID:           roomID,
		UserID:       req.UID,
		PatientID:    req.PatientID,
		Status:       0,
		CreatedAt:    time.Now(),
		EmergencyID:  req.EmergencyID,
		Location:     req.Location,
		Participants: []string{}, // Empty participants
	}

	// Add Room document to Firestore
	_, err = bootstrap.FirestoreClient.Collection("room").Doc(roomID).Set(ctx, room)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to create SOS room"})
	}

	// Notify users in the vicinity
	if err := notifyUsersInVicinity(ctx, req.Location, roomID, req.ImageLink, req.UID); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: err.Error()})
	}

	// Return the created Room ID
	response := map[string]string{"roomID": roomID}
	return c.JSON(http.StatusCreated, response)
}

// notifyUsersInVicinity sends push notifications to users within 500m of the specified location
// notifyUsersInVicinity sends push notifications to users within 500m of the specified location
func notifyUsersInVicinity(ctx context.Context, location domain.GeoPoint, roomID string, imageLink string, roomCreatorID string) error {
	// Find users within 500m of the specified location
	users, err := findUsersInVicinity(ctx, location, 500)
	if err != nil {
		return err
	}

	// Collect FCM tokens from users, excluding the room creator
	var tokens []string
	for _, user := range users {
		if user.ID != roomCreatorID {
			tokens = append(tokens, user.FcmTokens...)
		}
	}

	// Send push notification to collected tokens
	title := "SOS at " + location.String()
	body := "Go help right now"
	data := map[string]string{
		"roomID":     roomID,
		"image_link": imageLink, // Include the image link in the notification data
	}

	if err := utils.SendFCMMessage(tokens, title, body, data); err != nil {
		return err
	}

	return nil
}

// findUsersInVicinity finds users within the specified radius of the given location
// findUsersInVicinity finds users within the specified radius of the given location
func findUsersInVicinity(ctx context.Context, location domain.GeoPoint, radius float64) ([]domain.UserInfo, error) {
	// Firestore collection name for users
	collectionName := "user"

	// Query users in Firestore collection "user" with location within the radius
	latQuery := bootstrap.FirestoreClient.Collection(collectionName).
		Where("location.lat", ">=", location.Lat-radius/111.32).
		Where("location.lat", "<=", location.Lat+radius/111.32)

	lngQuery := bootstrap.FirestoreClient.Collection(collectionName).
		Where("location.lng", ">=", location.Lng-radius/(111.32*cosRadians(location.Lat))).
		Where("location.lng", "<=", location.Lng+radius/(111.32*cosRadians(location.Lat)))

	var users []domain.UserInfo

	// Combine the results of both queries
	latIter := latQuery.Documents(ctx)
	for {
		doc, err := latIter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return nil, err
		}

		// Map Firestore document to UserInfo struct
		var user domain.UserInfo
		if err := doc.DataTo(&user); err != nil {
			return nil, err
		}

		users = append(users, user)
	}

	lngIter := lngQuery.Documents(ctx)
	for {
		doc, err := lngIter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return nil, err
		}

		// Map Firestore document to UserInfo struct
		var user domain.UserInfo
		if err := doc.DataTo(&user); err != nil {
			return nil, err
		}

		// Ensure the user is not duplicated in the results
		duplicate := false
		for _, existingUser := range users {
			if existingUser.ID == user.ID {
				duplicate = true
				break
			}
		}

		if !duplicate {
			users = append(users, user)
		}
	}

	print("hello", users)

	return users, nil
}

// cosRadians calculates the cosine of an angle in radians
func cosRadians(angle float64) float64 {
	return math.Cos(angle * math.Pi / 180.0)
}

// getNewRoomID generates a new room ID by finding the maximum existing ID and incrementing it
// getNewRoomID generates a new room ID by finding the maximum existing ID and incrementing it
func getNewRoomID(ctx context.Context) (string, error) {
	// Find the maximum room ID in Firestore
	query := bootstrap.FirestoreClient.Collection("room").OrderBy("ID", firestore.Desc).Limit(1)
	iter := query.Documents(ctx)
	doc, err := iter.Next()
	if err != nil && err != iterator.Done {
		return "", err
	}

	// If no documents found, start with ID 1
	if doc == nil {
		return "1", nil
	}

	// Increment the maximum ID
	var maxID int
	err = doc.DataTo(&maxID)
	if err != nil {
		return "", err
	}
	newID := maxID + 1

	return strconv.Itoa(newID), nil
}

type CloseRoomRequest struct {
	RoomID string `json:"roomID"`
}

// CloseRoom closes an SOS room by setting its status to -1
func CloseRoom(c echo.Context) error {
	req := new(CloseRoomRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	// Update Room document to set status to -1
	updateData := map[string]interface{}{"status": -1}
	_, err := bootstrap.FirestoreClient.Collection("room").Doc(req.RoomID).Set(ctx, updateData, firestore.MergeAll)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to close SOS room"})
	}

	return c.NoContent(http.StatusOK)
}

type AcceptRoomRequest struct {
	UID    string `json:"uid"`
	RoomID string `json:"roomID"`
}

// AcceptRoom adds a participant to an SOS room in Firestore
// AcceptRoom adds a participant to an SOS room in Firestore
func AcceptRoom(c echo.Context) error {
	req := new(AcceptRoomRequest)
	if err := c.Bind(req); err != nil {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Invalid request payload"})
	}

	ctx := context.Background()

	// Get the existing room document
	roomDoc, err := bootstrap.FirestoreClient.Collection("room").Doc(req.RoomID).Get(ctx)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to get room from Firestore"})
	}

	// Check if the room is closed (status = -1)
	var existingRoom domain.Room
	if err := roomDoc.DataTo(&existingRoom); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to parse room data"})
	}

	if existingRoom.Status == -1 {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Cannot join a closed room"})
	}

	// Check if the room has reached the maximum number of participants (5)
	if len(existingRoom.Participants) >= 5 {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Room is full. Cannot accept more participants"})
	}

	// Update the participants field
	newParticipants := append(existingRoom.Participants, req.UID)
	updateData := map[string]interface{}{"participants": newParticipants}

	if _, err := roomDoc.Ref.Set(ctx, updateData, firestore.MergeAll); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to update room participants"})
	}

	return c.NoContent(http.StatusOK)
}

type RoomLocationStateResponse struct {
	ParticipantsLocation []ParticipantLocation `json:"participantsLocation"`
}

// ParticipantLocation represents the location of a participant
type ParticipantLocation struct {
	UID      string          `json:"uid"`
	Location domain.GeoPoint `json:"location"`
}

// RoomLocationState retrieves the location state of all participants in a room
func RoomLocationState(c echo.Context) error {
	roomID := c.QueryParam("roomID")
	if roomID == "" {
		return c.JSON(http.StatusBadRequest, domain.ErrorResponse{Message: "Room ID is required"})
	}

	ctx := context.Background()

	// Get the participants of the room
	roomDoc, err := bootstrap.FirestoreClient.Collection("room").Doc(roomID).Get(ctx)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to get room information"})
	}

	var room domain.Room
	if err := roomDoc.DataTo(&room); err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Failed to parse room information"})
	}

	// Get the location of each participant
	participantsLocation := make([]ParticipantLocation, 0)
	for _, participantUID := range room.Participants {
		userDoc, err := bootstrap.FirestoreClient.Collection("user").Doc(participantUID).Get(ctx)
		if err != nil {
			// Handle the error as needed
			continue
		}

		var user domain.UserInfo
		if err := userDoc.DataTo(&user); err != nil {
			// Handle the error as needed
			continue
		}

		participantLocation := ParticipantLocation{
			UID:      participantUID,
			Location: user.Location,
		}

		participantsLocation = append(participantsLocation, participantLocation)
	}

	response := RoomLocationStateResponse{
		ParticipantsLocation: participantsLocation,
	}

	return c.JSON(http.StatusOK, response)
}
