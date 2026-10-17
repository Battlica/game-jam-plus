extends Node

var respawn_point := Vector2(537, 75)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# If player enters death zone, they either lose a life and respawn or lose the game
func _on_death_zone_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.lives -= 1
		if body.lives <= 0:
			# end game
			print(body.name + " lost")
		else:
			print(body.name + " lives: " + str(body.lives))
			body.position = Vector2(537, 75)
