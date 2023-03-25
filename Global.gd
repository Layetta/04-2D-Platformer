extends Node

var score = 0
var lives = 3 
var level = 1 

onready var Player = load("res://Player/Player.tscn")
var starting_position = Vector2(200,200)


func _ready():
	pass


func _physics_process(_delta):
	if not has_node("Player"):
		var player = Player.instance()
		player.position = starting_position
		add_child(player)
