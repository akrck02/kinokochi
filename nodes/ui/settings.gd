extends Control
@onready var control = $"../../.."
@onready var outline_check_button = $"../OutlineCheckButton"

var outline:bool=true

# Called when the node enters the scene tree for the first time.
func _ready():
	outline_check_button.button_pressed=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_exit_click():
	control.set_visible(false)

func toggle_outline():
	SignalDatabase.outline.emit(!outline)
	outline=!outline
