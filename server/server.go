package main

import (
	"fmt"
	"context"
	"net/http"

	"github.com/labstack/echo/v4"
	"google.golang.org/api/option"
	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"
)

func main() {
	opt := option.WithCredentialsFile("server\configs\firstaid-b3f79-firebase-adminsdk-zdw1h-f40d04c897.json")
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		return nil, fmt.Errorf("error initializing app: %v", err)
	}	

	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})
	e.Logger.Fatal(e.Start(":1323"))
}
