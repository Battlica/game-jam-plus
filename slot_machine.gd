extends Control

var symbols := ["⚔️", "🛡️", "❤️"]

@onready var reel_1: Label = $Reel1
@onready var reel_2: Label = $Reel2
@onready var reel_3: Label = $Reel3
@onready var result_label: Label = $ResultLabel
@onready var spin_button: Button = $SpinButton


func _ready() -> void:
	spin_button.pressed.connect(spin)
	result_label.text = "Press Spin!"
	print("Slot machine ready")


func spin() -> void:
	print("Spin clicked")

	var result := [
		symbols.pick_random(),
		symbols.pick_random(),
		symbols.pick_random()
	]

	reel_1.text = result[0]
	reel_2.text = result[1]
	reel_3.text = result[2]

	result_label.text = get_reward_text(result)


func get_reward_text(result: Array) -> String:
	var sword_count := result.count("⚔️")
	var shield_count := result.count("🛡️")
	var heart_count := result.count("❤️")

	# Triple rewards
	if sword_count == 3:
		return "Triple swords!\n+2 Attack"

	if shield_count == 3:
		return "Triple shields!\nDamage taken ×0.25"

	if heart_count == 3:
		return "Triple hearts!\nHeal 4 HP"

	# Pair rewards
	if sword_count == 2:
		return "Sword pair!\n+1 Attack"

	if shield_count == 2:
		return "Shield pair!\nDamage taken ×0.5"

	if heart_count == 2:
		return "Heart pair!\nHeal 2 HP"

	# All three symbols are different
	return "No matching symbols\nNo reward"


func _on_spin_timer_timeout() -> void:
	spin()
