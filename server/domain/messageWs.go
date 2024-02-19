package domain

import (
	"encoding/json"
	"log"
)

const SendMessageAction 		= "send-message"
const UpdatePosition		 		= "update-position"
const CreateRoomAction 			= "create-room"
const JoinRoomAction 				= "join-room"
const LeaveRoomAction 			= "leave-room"
const UserJoinedAction 			= "user-join"      // online
const UserLeftAction 				= "user-left"			 // offline
const JoinRoomPrivateAction = "join-room-private"
const RoomJoinedAction 			= "room-joined"

type Message struct {
	Action  string  `json:"action"`
	Message string  `json:"message"`
	Target  *Room   `json:"target"`
	Sender  *Client `json:"sender"`
}

func (message *Message) encode() []byte {
	json, err := json.Marshal(message)
	if err != nil {
		log.Println(err)
	}

	return json
}

