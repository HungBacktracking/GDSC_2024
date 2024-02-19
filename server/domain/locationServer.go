package domain

type WsServer struct {
	clients    map[*Client]bool
	register   chan *Client
	unregister chan *Client
	broadcast  chan []byte
	rooms      map[string]map[*Client]bool
}

func NewWebsocketServer() *WsServer {
	return &WsServer{
		clients:    make(map[*Client]bool),
		register:   make(chan *Client),
		unregister: make(chan *Client),
		broadcast:  make(chan []byte),
		rooms:      make(map[string]map[*Client]bool),
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
}

func (server *WsServer) unregisterClient(client *Client) {
}

func (server *WsServer) broadcastToClients(message []byte) {
}