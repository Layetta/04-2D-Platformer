extends TileMap

func _ready():
	for x in range(128):
		for y in range(1):
			set_cellv(Vector2(x,y+9),3)
