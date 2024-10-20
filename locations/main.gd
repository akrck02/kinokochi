extends Control

var started : bool = false
var next_scene : String = Paths.get_world().get_scene() # Paths.get_debug_scene("test").get_scene() 

# Check input
func _input(_event):
	if not started and Input.is_action_just_pressed("ui_accept"):
		start_game()

# Start the game
func start_game():
	started = true
	SignalDatabase.scene_change_requested.emit(next_scene)
	queue_free()
