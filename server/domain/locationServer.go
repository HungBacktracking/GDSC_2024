package domain

import (
	"fmt"
)

type WsServer struct {
	clients    map[*Client]bool
	register   chan *Client
	unregister chan *Client
	broadcast  chan []byte
	rooms      map[*Room]bool
	roomsList  map[int]*Room
}

func NewWebsocketServer() *WsServer {
	return &WsServer{
		clients:    make(map[*Client]bool),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		broadcast:  make(chan []byte),
		rooms:      make(map[*Room]bool),
		roomsList:  make(map[int]*Room),
	}
}

func (server *WsServer) Run() {
	for {
		select {
		case client := <-server.register:
			server.registerClient(client)

		case client := <-server.unregister:
			server.unregisterClient(client)

		case message := <-server.broadcast:
			server.broadcastToClients(message)
		}
	}
}

// TODO: Implement the following methods
func (server *WsServer) registerClient(client *Client) {
	server.notifyClientJoined(client)
	server.listOnlineClients(client)
	server.clients[client] = true
}

func (server *WsServer) unregisterClient(client *Client) {
	if _, ok := server.clients[client]; ok {
		delete(server.clients, client)
		server.notifyClientLeft(client)
	}
}

func (server *WsServer) broadcastToClients(message []byte) {
	for client := range server.clients {
		client.send <- message
	}
}

func (server *WsServer) notifyClientJoined(client *Client) {
	// broadcast to all clients that a new client has joined
	fmt.Println("notifyClientJoined")
}

func (server *WsServer) notifyClientLeft(client *Client) {
	// broadcast to all clients that a client has left
	fmt.Println("notifyClientLeft")
}

func (server *WsServer) listOnlineClients(client *Client) {
	// list all online clients to the new client
	fmt.Println("listOnlineClients")
}

func (server *WsServer) CreateRoom(id int, name string, isPrivate bool) *Room {
	room := NewRoom(id, name, isPrivate)
	server.rooms[room] = true
	server.roomsList[id] = room
	go room.RunRoom()
	return room
}

func (server *WsServer) GetRoomByID(id int) (*Room, bool) {
	room, ok := server.roomsList[id]
	return room, ok
}