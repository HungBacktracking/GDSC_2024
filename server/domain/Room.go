package domain

import (
	"time"
)

// Room represents the structure of a document in the "room" collection in Firestore
type Room struct {
	ID           string    `firestore:"id"`
	UserID       string    `firestore:"userID"`
	PatientID    string    `firestore:"patientID"`
	Status       int       `firestore:"status"`
	CreatedAt    time.Time `firestore:"createdAt"`
	EmergencyID  []int     `firestore:"emergencyId"`
	Location     GeoPoint  `firestore:"location"`
	Participants []string  `firestore:"participants"`
}
