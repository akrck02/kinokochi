extends Control
@onready var outline_check_button : Button = $Scroll/Margin/Controls/OutlineCheckButton
@onready var exit_button : Button = $Scroll/Margin/Controls/ExitButton

var outline : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	outline_check_button.button_pressed=false
	outline_check_button.pressed.connect(toggle_outline)
	exit_button.pressed.connect(exit)

func exit():
	SignalDatabase.camera_movement_updated.emit(true);
	set_visible(false)

func toggle_outline():
	SignalDatabase.outline.emit(!outline)
	outline=!outline
