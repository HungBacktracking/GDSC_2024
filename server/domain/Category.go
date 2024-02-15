package domain

// Category represents the structure of the category document in Firestore
type Category struct {
	ID          int    `firestore:"id"`
	Name        string `firestore:"name"`
	Description string `firestore:"description"`
	Image       string `firestore:"image"`
	ContentID   int    `firestore:"contentID"`
	Children    []int  `firestore:"children"`
}
