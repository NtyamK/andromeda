extends Node

const SERVER_PORT = 8080
const SERVER_IP = "ec2-13-60-223-166.eu-north-1.compute.amazonaws.com"

signal client_connected()
signal client_disconnected()
signal on_status_updated(status: String)

var status = "[andromeda]: Not ready."

# Called when the node enters the scene tree for the first time.

func init() -> void:
	on_status_updated.emit("[andromeda]: 			server init script loaded.")
	if OS.has_feature("dedicated_server"):
		on_status_updated.emit("[andromeda-aws-ec2]: 	starting dedicated server...")
		host()
	else:
		on_status_updated.emit("[andromeda-aws-ec2]: 	attempting to connect the client...")
		connect_as_client()

func host():
	on_status_updated.emit("[andromeda-aws-ec2]: 	starting host.")

	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer

	multiplayer.peer_connected.connect(on_client_connected)
	multiplayer.peer_disconnected.connect(on_client_disconnected)

func connect_as_client():
	on_status_updated.emit("[andromeda-aws-ec2]: 	connecting the client...")

	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	
	multiplayer.multiplayer_peer = client_peer
	
func on_client_connected():
	emit_signal("client_connected")
	on_status_updated.emit("[andromeda-aws-ec2]: 	client connected.")
	
func on_client_disconnected():
	emit_signal("client_disconnected")
	on_status_updated.emit("[andromeda-aws-ec2]: 	client disconnected.")
