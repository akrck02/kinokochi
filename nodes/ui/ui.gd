extends CanvasLayer

@onready var timeLabel : RichTextLabel = $Time 
var current_tick : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.tick_reached.connect(show_tick);

func _input(_event):
	if Input.is_action_just_released('ui_zoom_in'):
		_on_zoom_in_button_pressed()
	if Input.is_action_just_released('ui_zoom_out'):
		_on_zoom_out_button_pressed()
	
func _on_zoom_in_button_pressed():
	SignalDatabase.zoom_in.emit(.5)

func _on_zoom_out_button_pressed():
	SignalDatabase.zoom_out.emit(.5)

func show_tick():
	current_tick += 1
	timeLabel.text = "[right] %s" % current_tick
