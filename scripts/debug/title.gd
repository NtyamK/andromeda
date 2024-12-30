extends Control

@onready var ui: VBoxContainer = %UI
@onready var logs: RichTextLabel = %Logs
@onready var find_match: Button = %FindMatch

var websocket_url = "wss://xguk2olqt9.execute-api.eu-north-1.amazonaws.com/production/"
var messageToSend = ""

@onready var web_socket_client: WebSocketClient = $WebSocketClient

func _connect_to_matchmaking_server():
	var error = web_socket_client.connect_to_url(websocket_url)
	if error != OK:
		%Logs.add_text("error connecting to websocket: %s" % [websocket_url])

func _on_websocket_message_received(message):
	%Logs.add_text("message received: %s" % message)

func _on_websocket_client_connection_close():
	var ws = web_socket_client.get_socket()
	%Logs.add_text("client disconnected with code: %s, reason: %s" % [ws.get_close_code(), ws.get_close_reason()])
	
func _on_websocket_client_connected_to_server():
	%Logs.add_text("client connected to server.\n")
	%Logs.add_text("waiting for match...\n")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ServerInit.has_signal("on_status_updated"):
		ServerInit.connect("on_status_updated", on_server_status_updated)
	ServerInit.init()


func on_server_status_updated(data: String):
	%Logs.add_text(data + "\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_find_match_pressed() -> void:
	var mock_id = str(randi() % 1000)
	var mock_user = {
		"playerId": mock_id,
		"username": "Player" + mock_id,
		"rank" : "311"
	}
	%Logs.add_text("measeret login not available.\nyou are %s." % mock_user["username"] + "\n")
	%Logs.add_text("waiting for client to connect..." + "\n")
	%FindMatch.hide()
	
	_connect_to_matchmaking_server()


func _on_create_matches_pressed() -> void:
	var messageToSend = "hello"
	web_socket_client.send(messageToSend)
