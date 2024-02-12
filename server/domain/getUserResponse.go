package domain

import (
	"time"
)

// GetUserResponse represents the response structure for GetUser endpoint
type GetUserResponse struct {
	UID         string    `json:"uid"`
	Name        string    `json:"name"`
	DisplayName string    `json:"displayName"`
	IsBanned    bool      `json:"isBanned"`
	IsActive    bool      `json:"isActive"`
	IsVolunteer bool      `json:"isVolunteer"`
	CreatedAt   time.Time `json:"createdAt"`
	Avatar      string    `json:"avatar"`
	UserInfo    *UserInfo `json:"userInfo"`
	// Omitted "Email" field
}
