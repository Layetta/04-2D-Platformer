extends KinematicBody2D

onready var SM = $StateMachine

export var walking = 50
export var running = 1000
#export var path = [Vector2(900,520), Vector2(1200,520)]
#export var path = [Vector2(900,200), Vector2(1200,200)]
export var path = [Vector2(0,520),Vector2(0,520)]
var velocity = Vector2.ZERO
var direction = 1

func _ready():
	#path = [Vector2(3000,520), Vector2(4000,520)]
	#path = [Vector2(400,520), Vector2(900,520)]
	#path = [Vector2(600,520), Vector2(1000,520)]
	position = path[0]
	velocity.x = walking
	SM.set_state("Move")
	walking = 100
	running = 1000



func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	if velocity.x < 0 and $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = false
		direction = -1
		$Attack.cast_to.x = -1*abs($Attack.cast_to.x)
	if velocity.x > 0 and not $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = true
		direction = 1
		$Attack.cast_to.x = abs($Attack.cast_to.x)
	if $AnimatedSprite.animation == "Attack": $AnimatedSprite.offset.x = 7*direction
	else: $AnimatedSprite.offset.x = 0

	
func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func damage():
	if SM.state_name != "Die":
		SM.set_state("Die")


func should_attack():
	if $Attack.is_colliding() and $Attack.get_collider().name == "Player":
		return true
	return false

func attack_target():
	if $Attack.is_colliding():
		return $Attack.get_collider()
	return null

func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		queue_free()


func _on_Above_and_Below_body_entered(body):
	if body.name == "Player" and SM.state_name != "Die":
		body.die()
