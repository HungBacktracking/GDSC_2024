package main

import (
	"server/routes"

	"github.com/labstack/echo/v4"

	"server/bootstrap"

	"log"
)

func main() {
	// Init database
	if err := bootstrap.InitializeDatabase(); err != nil {
		log.Fatalf("Error initializing database: %v", err)
	}

	// Echo framework
	e := echo.New()
	routes.RegisterHomeRoutes(e)
	routes.RegisterUserRoutes(e)
	routes.RegisterCategoryRoutes(e)

	e.Logger.Fatal(e.Start(":1323"))
}
