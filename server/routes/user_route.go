package routes

import (
	"server/controllers"

	"github.com/labstack/echo/v4"
)

func RegisterUserRoutes(e *echo.Echo) {
	e.POST("/get_user", controllers.GetUser)
}
