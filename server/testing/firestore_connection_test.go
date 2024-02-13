package testing

import (
	"context"
	"fmt"
	"log"
	"server/bootstrap"
	"server/domain"
	"testing"

	"google.golang.org/api/iterator"
)

func TestFindUserById(t *testing.T) {
	// Initialize Firebase App and Firestore Client
	if err := bootstrap.InitializeDatabase(); err != nil {
		t.Fatalf("Error initializing database: %v", err)
	}

	// Replace "your-collection-name" with the actual name of your Firestore collection
	collectionName := "user"

	// Replace "your-id-value" with the actual value you want to search for
	idValue := "YtwhCfD5L6TWS8EpXlcWwMhjsZC3"

	// Create a context and a Firestore client
	ctx := context.Background()
	client := bootstrap.FirestoreClient

	// Create a query to find documents where the "id" field equals the specified value
	query := client.Collection(collectionName).Where("id", "==", idValue)

	// Execute the query
	iter := query.Documents(ctx)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			log.Printf("Error iterating over query results: %v", err)
			break
		}

		// Map Firestore document to UserInfo struct
		var user domain.UserInfo
		if err := doc.DataTo(&user); err != nil {
			log.Printf("Error mapping Firestore document to UserInfo struct: %v", err)
			continue
		}

		// Print the user information
		fmt.Printf("User Information:\n")
		fmt.Printf("Name: %s\n", user.Name)
		fmt.Printf("IsBanned: %v\n", user.IsBanned)
		fmt.Printf("IsActive: %v\n", user.IsActive)
		fmt.Printf("IsVolunteer: %v\n", user.IsVolunteer)
		fmt.Printf("CreatedAt: %v\n", user.CreatedAt)
		fmt.Printf("Avatar: %s\n", user.Avatar)
	}
}
