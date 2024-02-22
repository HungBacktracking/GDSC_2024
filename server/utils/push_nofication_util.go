package main

import (
	"context"
	"log"

	"server/bootstrap"

	"firebase.google.com/go/messaging"
)

func sendFCMMessage(deviceTokens []string, title, body string, data map[string]string) error {
	message := &messaging.MulticastMessage{
		Notification: &messaging.Notification{
			Title: title,
			Body:  body,
		},
		Data:   data,
		Tokens: deviceTokens,
	}

	response, err := bootstrap.FCMClient.SendMulticast(context.Background(), message)
	if err != nil {
		return err
	}

	// Handle the FCM response if needed
	log.Printf("Successfully sent FCM message. Response: %+v\n", response)
	return nil
}
