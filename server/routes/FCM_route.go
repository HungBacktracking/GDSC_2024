package routes

import (
	"server/controllers"

	"github.com/labstack/echo/v4"
)

func RegisterFCMRoutes(e *echo.Echo) {
	e.POST("/fcm/add_token", controllers.AddToken)
}
