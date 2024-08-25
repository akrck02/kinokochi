extends Control

var started : bool = false

func _input(_event):
	if not started and Input.is_action_just_pressed("ui_accept"):
		start_game()

# Start the game
func start_game():
	started = true
	SignalDatabase.scene_change_requested.emit("debug/test_chamber_1")
	queue_free()
