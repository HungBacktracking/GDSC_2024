package testing

import (
	"context"
	"fmt"
	"log"

	"firebase.google.com/go/auth"

	"server/bootstrap"
)

func main() {
	if err := bootstrap.InitializeDatabase(); err != nil {
		log.Fatalf("Error initializing database: %v", err)
	}

	authClient, err := bootstrap.FirebaseApp.Auth(context.Background())
	if err != nil {
		log.Fatalf("Error creating Auth client: %v", err)
	}

	phoneNumber := "+84868734807" // Replace with the user's phone number

	// Step 1: Send a verification code
	settings := (&auth.ActionCodeSettings{}).SetPhoneNumber(phoneNumber)

	verificationID, err := authClient.SendVerificationCode(context.Background(), settings)
	if err != nil {
		log.Fatalf("Error sending verification code: %v", err)
	}

	fmt.Printf("Verification code sent successfully. Verification ID: %s\n", verificationID)
}
