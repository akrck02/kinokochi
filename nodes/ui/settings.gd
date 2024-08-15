extends Control
@onready var control = $"../../.."
@onready var outline_check_button = $"../OutlineCheckButton"
@onready var volume_h_slider = $"../HBoxContainer/VolumeHSlider"


# Called when the node enters the scene tree for the first time.
func _ready():
	outline_check_button.button_pressed=SettingsManager.get_value("settings", "outline")
	volume_h_slider.value=SettingsManager.get_value("settings", "volume")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_exit_click():
	control.set_visible(false)
	


func toggle_outline():
	var outline:bool=SettingsManager.get_value("settings", "outline")
	SettingsManager.set_value("settings", "outline", !outline)
	SignalDatabase.outline.emit(!outline)


func set_volume(value:float):
	var bus_index=AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
