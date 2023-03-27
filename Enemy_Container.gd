extends Node2D

onready var Golem = load("res://Enemies/Golem.tscn")


func _physics_process(_delta):
	if not has_node("Golem"):
		var golem = Golem.instance()
		golem.path = [Vector2(600,520), Vector2(1000,520)]
		add_child(golem)
		
		var golem2 = Golem.instance()
		golem2.path = [Vector2(1500,520), Vector2(2000,520)]
		add_child(golem2)
		
