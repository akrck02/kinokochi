extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if Input.is_action_just_released('ui_zoom_in'):
		_on_zoom_in_button_pressed()
	if Input.is_action_just_released('ui_zoom_out'):
		_on_zoom_out_button_pressed()

func _on_zoom_in_button_pressed():
	SignalDatabase.zoom_in.emit(.25)


func _on_zoom_out_button_pressed():
	SignalDatabase.zoom_out.emit(.25)
