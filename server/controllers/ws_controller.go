package controllers

import (
	"server/usecases"

	"github.com/labstack/echo/v4"
)

/*
* Get information connected to the websocket
*  1. user_id (webtoken => jwt)
 */
func HandleWebsocketConnection(e echo.Context) error {
	// check information

	// call usecase.ServeWs
	usecases.ServeWs()
	// usecases.ServeWs(wsServer, w, r)
	return nil
}