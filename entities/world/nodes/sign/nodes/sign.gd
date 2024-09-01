extends Node2D

@export var scene : String = "park"
@onready var area_2d : Area2D = $Area2D
var change_requested = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.input_event.connect(handle_input)

# Handle input
func handle_input(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	
	if change_requested or !Input.is_action_just_pressed("ui_accept"):
		return
	
	SignalDatabase.scene_change_requested.emit(scene)
	change_requested = true
