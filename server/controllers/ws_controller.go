package controllers

import (
	"fmt"

	"github.com/labstack/echo/v4"
)

/*
* Get information connected to the websocket
*  1. user_id (webtoken => jwt)
 */
func HandleWebsocketConnection(e echo.Context) error {
	// check information

	// call usecase.ServeWs
	ServeWs()
	// usecases.ServeWs(wsServer, w, r)
	return nil
}

func ServeWs() {
	fmt.Println("ServeWs")
}
// ServeWs handles websocket requests from clients requests.
// func ServeWs(wsServer *WsServer, w http.ResponseWriter, r *http.Request) {

// 	name, ok := r.URL.Query()["name"]

// 	if !ok || len(name[0]) < 1 {
// 		log.Println("Url Param 'name' is missing")
// 		return
// 	}

// 	conn, err := upgrader.Upgrade(w, r, nil)
// 	if err != nil {
// 		log.Println(err)
// 		return
// 	}

// 	client := newClient(conn, wsServer, name[0])

// 	go client.writePump()
// 	go client.readPump()

// 	wsServer.register <- client
// }