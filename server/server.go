package main

import (
	// "github.com/labstack/echo/v4"

	"server/bootstrap"

	"log"

	"context"
)

func main() {
	// Init database
	if err := bootstrap.InitializeDatabase(); err != nil {
		log.Fatalf("Error initializing database: %v", err)
	}

	// Echo framework
	// e := echo.New()
	// routes.RegisterHomeRoutes(e)
	// routes.RegisterUserRoutes(e)

	// e.Logger.Fatal(e.Start(":1323"))

	uid := "YtwhCfD5L6TWS8EpXlcWwMhjsZC3"

	client := bootstrap.FirestoreClient

	// Replace "users" with the actual collection name in your Firestore
	collection := client.Collection("users")

	// Query for the document with the specified UID
	docRef := collection.Where("uid", "==", uid).Documents(context.Background())
	docs, err := docRef.GetAll()
	if err != nil {
		return nil, err
	}

}
