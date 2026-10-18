extends Node2D

var symbols := ["⚔️", "🛡️", "❤️"]
var result: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spin() -> void:
	result = [
		symbols.pick_random(),
		symbols.pick_random(),
		symbols.pick_random()
	]
	
	$HBoxContainer/Reel1.text = result[0]
	$HBoxContainer/Reel2.text = result[1]
	$HBoxContainer/Reel3.text = result[2]
	
	$Result.text = get_reward_text(result)


func get_reward_text(result: Array) -> String:
	var sword_count := result.count("⚔️")
	var shield_count := result.count("🛡️")
	var heart_count := result.count("❤️")
	
	# Triple rewards
	if sword_count == 3:
		return "Triple swords!\n+2 Attack"
		
	if shield_count == 3:
		return "Triple shields!\nInvincibility for 6s"
		
	if heart_count == 3:
		return "Triple hearts!\nHeal 4 HP"
		
	# Pair rewards
	if sword_count == 2:
		return "Sword pair!\n+1 Attack"
		
	if shield_count == 2:
		return "Shield pair!\nInvincibility for 3s"
		
	if heart_count == 2:
		return "Heart pair!\nHeal 2 HP"
		
	# All three symbols are different
	return "No reward"
