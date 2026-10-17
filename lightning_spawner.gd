extends Node

@export var max_x: float
@export var min_x: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interval_timer_timeout() -> void:
	$WarningTimer.start()
	$WarningLabel.text = "!"


func _on_warning_timer_timeout() -> void:
	$WarningLabel.text = ""
	$IntervalTimer.start()


func start_interval_timer():
	$IntervalTimer.start()
