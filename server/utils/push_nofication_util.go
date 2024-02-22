package utils

type (
	// PushNotification represents the structure of a push notification
	PushNotification struct {
		Title string `json:"title"`
		Body  string `json:"body"`
	}
)

func SendNotification() {

}