extends CharacterBody2D

@export var player_id: int

var left
var right
var jump
var push
var lives := 3
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 100
const FRICTION = 20


func _ready() -> void:
	left = "p" + str(player_id) + "_left"
	right = "p" + str(player_id) + "_right"
	jump = "p" + str(player_id) + "_jump"
	push = "p" + str(player_id) + "_push"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle left and right
	var direction := Input.get_axis(left, right)
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	if Input.is_action_just_pressed(push):
		velocity.x = 1000
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	move_and_slide()
	
