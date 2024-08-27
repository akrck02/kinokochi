extends Node2D

@onready var exit_button = $TouchScreenButton 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.pressed.connect(exit)

# Exit to map
func exit():
	SignalDatabase.scene_change_requested.emit("park")
	queue_free()
