extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func load_scene(path: String) -> void:
	get_tree().call_deferred("change_scene_to_file", path)


func _on_fake_load_timeout() -> void:
	load_scene("res://scenes/title.tscn")
	pass # Replace with function body.
