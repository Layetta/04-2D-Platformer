extends Node

func _ready():
	OS.window_position = Vector2(0,0)
	OS.window_size = Vector2(1080,800)
	

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
