extends Node

var respawn_point := Vector2(537, 75)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player1.player_hit.connect($"."._on_player_hit)
	$Player2.player_hit.connect($"."._on_player_hit)
	$LightningSpawner.player_hit.connect($"."._on_player_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HUD.display_current_time($GameTimer.get_time_left())


# When the player dies, check if they lose a life and respawn, or game ends
func lose_life(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.lives -= 1
		$HUD.on_lives_changed(body.name, body.lives)
		
		# If no more lives, end game, else respawn
		if body.lives <= 0:
			# End the game with the Win Screen
			get_tree().paused = true
			$WinMenu.visible = true
			if body.name == "Player1":
				$WinMenu/Label.text = "Player 2 Wins!"
			elif body.name == "Player2":
				$WinMenu/Label.text = "Player 1 Wins!"
		else:
			# Respawn the player
			body.position = respawn_point
			

# When time runs out, start the lighting overtime.
func _on_game_timer_timeout() -> void:
	$LightningSpawner.start_interval_timer()


func _on_player_hit(player):
	lose_life(player)
