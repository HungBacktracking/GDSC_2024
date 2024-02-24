package routes

import (
	"server/controllers"

	"github.com/labstack/echo/v4"
)

func RegisterSOSRoutes(e *echo.Echo) {
	e.POST("/sos/create_room", controllers.CreateRoom)
	e.POST("/sos/close_room", controllers.CloseRoom)
	e.POST("/sos/accept_room", controllers.AcceptRoom)
	e.GET("/sos/room_location_state", controllers.RoomLocationState)
}
