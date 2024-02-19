package domain

import (
	"fmt"
)

type Room struct {
	id         int							`json:"id"`
	name       string						`json:"name"`
	clients    map[*Client]bool
	register   chan *Client
	unregister chan *Client
	broadcast  chan []byte
	isPrivate  bool							`json:"private"`
}

func NewRoom(id int, name string, isPrivate bool) *Room {
	getName := func(name string) string {
		if name == "" {
			return "Anonymous Room ID: " + fmt.Sprintf("%d", id)
		}
		return name
	}

	return &Room{
		id:         id,
		name:       getName(name),
		clients:    make(map[*Client]bool),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		broadcast:  make(chan []byte),
		isPrivate:  isPrivate,
	}
}

func (room *Room) RunRoom() {
	for {
		select {
		case client := <-room.register:
			room.registerClientInRoom(client)

		case client := <-room.unregister:
			room.unregisterClientInRoom(client)

		case message := <-room.broadcast:
			room.broadcastToClientsInRoom(message)
		}
	}
}

func (room *Room) registerClientInRoom(client *Client) {
}

func (room *Room) unregisterClientInRoom(client *Client) {
}

func (room *Room) broadcastToClientsInRoom(message []byte) {
}

func (room *Room) GetID() int {
	return room.id
}

func (room *Room) GetName() string {
	return room.name
}

func (room *Room) IsPrivate() bool {
	return room.isPrivate
}

func (room *Room) HasClient(client *Client) bool {
	if _, ok := room.clients[client]; ok {
		return true
	}
	return false
}