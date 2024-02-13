// bootstrap/database.go
package bootstrap

import (
	"context"
	"log"
	"os"
	"path/filepath"
	"server/configs"

	"cloud.google.com/go/firestore"
	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
)

var (
	serviceAccountPath = "configs/service_account.json"

	FirebaseApp     *firebase.App
	FirestoreClient *firestore.Client
)

// SetServiceAccountPath sets the path to the service account JSON file.
func SetServiceAccountPath(path string) {
	serviceAccountPath = path
}

// InitializeApp initializes and returns a Firebase app instance
func InitializeApp() (*firebase.App, error) {
	opt := option.WithCredentialsFile(serviceAccountPath)
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		log.Printf("Error initializing app: %v", err)
		return nil, err
	}
	return app, nil
}

// InitializeFirestore initializes and returns a Firestore client instance
func InitializeFirestore() (*firestore.Client, error) {
	opt := option.WithCredentialsFile(serviceAccountPath)

	// Load service account from JSON
	serviceAccount, err := configs.LoadServiceAccount(serviceAccountPath)
	if err != nil {
		return nil, err
	}

	// Access the project ID
	projectID := serviceAccount.ProjectID

	client, err := firestore.NewClient(context.Background(), projectID, opt)
	if err != nil {
		log.Printf("Error initializing Firestore client: %v", err)
		return nil, err
	}
	return client, nil
}

// InitializeDatabase initializes Firebase App and Firestore Client
func InitializeDatabase() error {
	// Get the current working directory
	cwd, err := os.Getwd()
	if err != nil {
		log.Printf("Error getting current working directory: %v", err)
		return err
	}

	// Construct the full path to the service account file
	serviceAccountPath = filepath.Join(cwd, serviceAccountPath)

	// Initialize Firebase App
	app, err := InitializeApp()
	if err != nil {
		return err
	}
	FirebaseApp = app

	// Initialize Firestore Client
	client, err := InitializeFirestore()
	if err != nil {
		return err
	}
	FirestoreClient = client

	return nil
}
