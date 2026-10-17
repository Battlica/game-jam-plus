extends CharacterBody2D

@export var player_id: int

signal player_hit(player)

var left
var right
var jump
var attack
var lives := 3
var saved_direction = 1
var invincible = false
const SPEED = 500.0
const JUMP_VELOCITY = -700.0
const ACCELERATION = 100
const FRICTION = 20


func _ready() -> void:
	left = "p" + str(player_id) + "_left"
	right = "p" + str(player_id) + "_right"
	jump = "p" + str(player_id) + "_jump"
	attack = "p" + str(player_id) + "_attack"


func _physics_process(delta: float) -> void:
	# When attack is pressed, if there is a player in the attack area, send a signal 
	if Input.is_action_just_pressed(attack):
		check_hit()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle left and right movement
	var direction := Input.get_axis(left, right)
	# Setting player hitbox direction
	if saved_direction != direction and direction != 0:
		saved_direction = direction
		$"AttackArea/CollisionShape2D".position.x *= -1
	
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	move_and_slide()


func check_hit():
	for body in $AttackArea.get_overlapping_bodies():
		if body is CharacterBody2D:
			if invincible == false:
				player_hit.emit(body)
