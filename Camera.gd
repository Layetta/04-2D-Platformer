extends Camera2D

onready var coins = get_node_or_null("/root/Game/Coins")

func _process(_delta):
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		position = player.position
		var score_text = get_node_or_null("/root/Game/Score")
		score_text.set_position(position+Vector2(-20,-60))


		score_text.set_text("Score: "+String(coins.numCoinsFound))
		
