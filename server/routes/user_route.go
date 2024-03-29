package routes

import (
	"server/controllers"

	"github.com/labstack/echo/v4"
)

func RegisterUserRoutes(e *echo.Echo) {
	e.POST("/user/get_user", controllers.GetUser)
	e.POST("/user/get_profile", controllers.GetProfile)
	e.POST("/user/add_user", controllers.AddUser)
	e.POST("/user/is_exist_phone", controllers.IsExistPhone)
	e.POST("/user/upd_location", controllers.UpdLocation)
	e.POST("/user/add_range", controllers.AddRange)
	e.POST("/user/delete_range", controllers.DeleteRange)
}
