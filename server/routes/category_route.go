package routes

import (
	"server/controllers"

	"github.com/labstack/echo/v4"
)

func RegisterCategoryRoutes(e *echo.Echo) {
	e.GET("/category/get_all", controllers.GetAllCategory)
}
