extends Area2D

var counter = 1


func _on_Exit_to_Next_Level_body_entered(body):
	if body.name == "Player":
		if name == "Exit_to_Next_Level":
			if(counter >= 2):
				print("different scene")
				var _target = get_tree().change_scene("res://Player/Player.tscn")
			else:
				var _target = get_tree().change_scene("res://Game.tscn")
			counter=counter + 1
			print(counter)
	return	
			
#		if name == "Exit_to_2":
#			var _target = get_tree().change_scene("res://Levels/Level2.tscn")
#		if name == "Exit_to_3":
#			var _target = get_tree().change_scene("res://Levels/Level3.tscn")
#		if name == "Exit_to_4":
#			var _target = get_tree().change_scene("res://Levels/Game_Over.tscn")
