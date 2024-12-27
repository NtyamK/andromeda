extends Node

const SERVER_PORT = 8080
const SERVER_IP = "ec2-13-60-223-166.eu-north-1.compute.amazonaws.com"

signal client_connected()
signal client_disconnected()
signal on_status_updated(status: String)

# Called when the node enters the scene tree for the first time.

func init() -> void:
	on_status_updated.emit("server init script loaded.")
	on_status_updated.emit("changing status...")
	if OS.has_feature("dedicated_server"):
		on_status_updated.emit("status recognized as host.")
		host()
	else:
		on_status_updated.emit("status recognized as client.")

func host():
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer

	multiplayer.peer_connected.connect(on_client_connected)
	multiplayer.peer_disconnected.connect(on_client_disconnected)

func connect_as_client(ip, port):
	on_status_updated.emit("connect as client.")
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(ip, port)
	
	multiplayer.multiplayer_peer = client_peer
	
func start_client(ip, port):
	on_status_updated.emit("status recognized as client.")
	connect_as_client(ip, port)
	
func on_client_connected():
	emit_signal("client_connected")
	on_status_updated.emit("client connected.")
	
func on_client_disconnected():
	emit_signal("client_disconnected")
	on_status_updated.emit("client disconnected.")
