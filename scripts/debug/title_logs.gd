extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ServerInit.has_signal("on_status_updated"):
		ServerInit.connect("on_status_updated", on_server_status_updated)

func on_server_status_updated(data: String):
	add_text(data + "\n")
