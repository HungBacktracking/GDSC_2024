package usecases

import (
	"fmt"
)

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