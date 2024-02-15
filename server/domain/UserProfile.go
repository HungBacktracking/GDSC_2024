package domain

// UserProfile represents the structure of the user profile document in Firestore
type UserProfile struct {
	Skills []int  `firestore:"skills"`
	Info   string `firestore:"info"`
}
