extends Control
@onready var outline_check_button : Button = $Scroll/Margin/Controls/OutlineCheckButton
@onready var exit_button : Button = $Scroll/Margin/Controls/ExitButton

var outline : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	outline_check_button.button_pressed=true
	outline_check_button.pressed.connect(toggle_outline)
	exit_button.pressed.connect(exit)

func exit():
	set_visible(false)

func toggle_outline():
	SignalDatabase.outline.emit(!outline)
	outline=!outline
