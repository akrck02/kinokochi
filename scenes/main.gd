extends Control


func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		start_game()

# Start the game
func start_game():
	SignalDatabase.scene_change_requested.emit("park")
	queue_free()
