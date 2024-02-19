package domain

import (
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/gorilla/websocket"
)

const (
	// Max wait time when writing message to peer
	writeWait = 10 * time.Second

	// Max time till next pong from peer
	pongWait = 60 * time.Second

	// Send ping interval, must be less then pong wait time
	pingPeriod = (pongWait * 9) / 10

	// Maximum message size allowed from peer.
	maxMessageSize = 10000
)

var (
	newline = []byte{'\n'}
	space   = []byte{' '}
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  4096,
	WriteBufferSize: 4096,
}

// Client represents the websocket client at the server
type Client struct {
	conn		 *websocket.Conn
	WsServer *WsServer
	send 		 chan []byte
	id 			 int								`json:"id"`
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

// read loop, waiting for messages from the websocket connection
// readPump pumps messages from the websocket connection to the WsServer
func (client *Client) readPump() {
	defer func() {
		client.disconnect()	
	}()

	client.conn.SetReadLimit(maxMessageSize)
	client.conn.SetReadDeadline(time.Now().Add(pongWait))
	client.conn.SetPongHandler(func(string) error {
		client.conn.SetReadDeadline(time.Now().Add(pongWait))
		return nil
	})

	// Start endless loop to read messages from the client
	for {
		_, jsonMessageByte, err := client.conn.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
				fmt.Println("error: ", err)
			}
			break
		}
		
		client.handleNewMessage(jsonMessageByte)
	}
}

func (client *Client) writePump() {
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		// client.conn.Close()
		client.disconnect()
	}()

	for {
		select {
		case message, ok := <-client.send:
			client.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				// WsServer closed the channel
				client.conn.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}

			w, err := client.conn.NextWriter(websocket.TextMessage)
			if err != nil {
				return
			}
			w.Write(message)

			// Add queued chat messages to the current websocket message
			// when client receive messages, need to split them by newline, and parse each message to solve. Is it OK?
			// n := len(client.send)
			// for i := 0; i < n; i++ {
			// 	w.Write(newline)
			// 	w.Write(<-client.send)
			// }

			if err := w.Close(); err != nil {
				return
			}
		case <-ticker.C:
			// write ping message to peer
			client.conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := client.conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

func (client *Client) disconnect() {
	client.WsServer.unregister <- client

	for room := range client.rooms {
		room.unregister <- client
	}

	close(client.send)

	client.conn.Close()
}

func (client *Client) handleNewMessage(jsonMessage []byte) {
	var message Message
	if err := json.Unmarshal(jsonMessage, &message); err != nil {
		log.Printf("Error on unmarshal JSON message %s", err)
		return
	}

	message.Sender = client
	
	switch message.Action {
	case UpdatePosition:
		client.handleUpdatePosition(message)
	case SendMessageAction:
		// send message to room
		// The send-message action, this will send messages to a specific room now.
		// Which room wil depend on the message Target
		client.handleSendMessage(message)
	case CreateRoomAction:
		client.handleCreateRoom(message)
	case JoinRoomAction:
		client.handleJoinRoom(message)
	case LeaveRoomAction:
		client.handleLeaveRoom(message)
	
	}
}

func (client *Client) handleUpdatePosition(message Message) {
	// update the position of the client
	// broadcast to the room need (all the room that the client is in)


}

func (client *Client) handleSendMessage(message Message) {
	roomID := message.Target.GetID()
	if room,_ := client.WsServer.GetRoomByID(roomID); room != nil {
		if !client.isInRoom(room) {
			room.broadcast <- message.encode()
		}
	}
}

func (client *Client) handleCreateRoom(message Message) {
	// TODO: Need check with database to make sure the room is not exist

	// room name in Target
	roomName := message.Target.GetName()
	isPrivate := message.Target.IsPrivate()
	roomID    := message.Target.GetID()

	client.WsServer.CreateRoom(roomID, roomName, isPrivate)
}

func (client *Client) handleJoinRoom(message Message) {
	roomID := message.Target.GetID()
	if room, ok := client.WsServer.GetRoomByID(roomID); ok {
		if !client.isInRoom(room) {
			client.rooms[room] = true
			room.register <- client
			client.notifyRoomJoined(room, nil)
		}
	}
}

func (client *Client) handleLeaveRoom(message Message) {
	roomID := message.Target.GetID()
	if room, ok := client.WsServer.GetRoomByID(roomID); ok {
		if client.isInRoom(room) {
			delete(client.rooms, room)
			room.unregister <- client
		}
	}
}

func (client *Client) notifyRoomJoined(room *Room, sender *Client) {
	message := Message{
		Action: RoomJoinedAction,
		Message: fmt.Sprintf("Client %s joined the room", client.name),
		Target: room,
		Sender: sender,
	}
	client.send <- message.encode()
}

func (client *Client) isInRoom(room *Room) bool {
	if _, ok := client.rooms[room]; ok {
		return true
	}
	return false
}