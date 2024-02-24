package domain

import (
	"time"
)

// UserInfo represents the structure of the user document in Firestore
type UserInfo struct {
	ID          string    `firestore:"id"`
	Name        string    `firestore:"name"`
	IsBanned    bool      `firestore:"isBanned"`
	IsActive    bool      `firestore:"isActive"`
	IsVolunteer bool      `firestore:"isVolunteer"`
	CreatedAt   time.Time `firestore:"createdAt"`
	Avatar      string    `firestore:"avatar"`
	FcmTokens   []string  `firestore:"fcm_tokens,omitempty"`
	Location    GeoPoint  `firestore:"location,omitempty"`
}
