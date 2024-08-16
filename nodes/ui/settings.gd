extends Control
@onready var outline_check_button : Button = $Scroll/Margin/Controls/OutlineCheckButton
@onready var exit_button : Button = $Scroll/Margin/Controls/ExitButton
@onready var volume_h_slider = $Scroll/Margin/Controls/VolumeControls/VolumeHSlider

var outline : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	volume_h_slider.value=SettingsManager.get_value("settings", "volume")
	outline_check_button.button_pressed=false
	outline_check_button.pressed.connect(toggle_outline)
	exit_button.pressed.connect(exit)
	volume_h_slider.value_changed.connect(set_volume)

func exit():
	SignalDatabase.camera_movement_updated.emit(true);
	set_visible(false)

func toggle_outline():
	SignalDatabase.outline.emit(!outline)
	outline=!outline

func set_volume(value:float):
	var bus_index=AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
