extends Control

var websocket_url = "wss://xguk2olqt9.execute-api.eu-north-1.amazonaws.com/production/"
var messageToSend = ""

@onready var _client : WebSocketClient = $WebSocketClient

func _connect_to_matchmaking_server():
	var error = _client.connect_to_url(websocket_url)
	if error != OK:
		print("Error connecting to websocket: %s" % [websocket_url])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Attempting to connect to server...")
	_connect_to_matchmaking_server()

func _on_websocket_message_received(message):
	print("Message received: %s" % message)

func _on_websocket_client_connection_close():
	var ws = _client.get_socket()
	print("Client disconnected with code: %s, reason: %s" % [ws.get_close_code(), ws.get_close_reason()])
	
func _on_websocket_client_connected_to_server():
	print("Client connected to server...")
	
