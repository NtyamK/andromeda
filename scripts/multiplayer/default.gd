extends Control
@onready var lobby_placeholder: Node = $LobbyPlaceholder

var lobby_scene = "res://scenes/multiplayer/lobby.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	print("Find match pressed")
	var lobby = load(lobby_scene)
	lobby_placeholder.add_child(lobby.instantiate())
