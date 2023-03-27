extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0,30)

export var move_speed = 20
export var max_move = 300

export var jump_speed = 200
export var max_jump = 1200

export var leap_speed = 200
export var max_leap = 1200

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite

var deaths = 0


func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = true
			$Attack.cast_to.x = -1*abs($Attack.cast_to.x)
		if direction > 0 and $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = false
			$Attack.cast_to.x = abs($Attack.cast_to.x)

	if is_on_floor():
		double_jumped = false
		set_wall_raycasts(true)
		if Input.is_action_just_pressed("attack"):
			SM.set_state("Attacking")

func is_moving():
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("Left"):
		direction = -1
	if event.is_action_pressed("Right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func die():
	Global.update_lives(-1)

	queue_free()
	
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attacking":
		SM.set_state("Idle")
		
		
func attack():
	if $Attack.is_colliding():
		var target = $Attack.get_collider()
		if target.has_method("damage"):
			target.damage()
	if $Attack_low.is_colliding():
		var target = $Attack_low.get_collider()
		if target.has_method("damage"):
			target.damage()
		

func _on_Coin_collector_body_entered(body):
	if body.name == "Coins":
		body.get_coin(global_position)

