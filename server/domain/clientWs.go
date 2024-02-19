package domain

import (
	"fmt"

	"github.com/gorilla/websocket"
)

// Client represents the websocket client at the server
type Client struct {
	conn		 *websocket.Conn
	WsServer *WsServer
	send 		 chan []byte
	id 			 int
	name		 string
	rooms		 map[*Room]bool
}

func newClient(conn *websocket.Conn, wsServer *WsServer, id int, name string) *Client {
	getName := func(name string) string {
		if name == "" {
			return "Anonymous Client ID: " + fmt.Sprintf("%d", id)
		}
		return name
	}
	
	return &Client{
		conn: 			conn,
		WsServer: 	wsServer,
		send: 			make(chan []byte),
		rooms: 			make(map[*Room]bool),
		id: 				id,	
		name: 			getName(name),
	}
}

// TODO: Implement the following methods
func (client *Client) readPump() {
}

func (client *Client) writePump() {
}

func (client *Client) disconnect() {
}



