extends Control

@onready var ui: VBoxContainer = %UI
@onready var logs: RichTextLabel = %Logs
@onready var find_match: Button = %FindMatch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ServerInit.has_signal("on_status_updated"):
		ServerInit.connect("on_status_updated", on_server_status_updated)
	ServerInit.init()


func on_server_status_updated(data: String):
	%Logs.add_text(data + "\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_find_match_pressed() -> void:
	%Logs.add_text("[andromeda]: Finding Match..." + "\n")
	%FindMatch.hide()
