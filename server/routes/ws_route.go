package routes

import (
	"server/controllers"

	"github.com/labstack/echo/v4"
)

func RegisterWebsocketRoutes(e *echo.Echo) {
	e.GET("/ws", controllers.HandleWebsocketConnection)
}
