extends Node

var lives = 3

func _ready():
	OS.window_position = Vector2(0,0)
	OS.window_size = Vector2(1080,800)
	

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func update_lives(l):
	lives+=l
	if lives <= 0:
		get_tree().quit()
	
