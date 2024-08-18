extends Control
@onready var outline_check_button : Button = $Scroll/Margin/Controls/OutlineCheckButton
@onready var exit_button : Button = $Scroll/Margin/Controls/ExitButton
@onready var general_volume_h_slider: HSlider = $Scroll/Margin/Controls/VolumeControls/GeneralVolumeHSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize values from settings
	general_volume_h_slider.value=SettingsManager.get_value("Volume", "General")
	outline_check_button.button_pressed=SettingsManager.get_value("Character","Outline")
	
	outline_check_button.pressed.connect(toggle_outline)
	exit_button.pressed.connect(exit)
	general_volume_h_slider.value_changed.connect(change_volume.bind(0))

func exit():
	SignalDatabase.camera_movement_updated.emit(true);
	set_visible(false)

func toggle_outline():
	var outline:bool=SettingsManager.get_value("Character", "Outline")
	SettingsManager.set_value("Character", "Outline", !outline)
	SignalDatabase.outline.emit(!outline)

func change_volume(value:float, bus:int):
	var buses_names=["General"]
	print("bus "+str(bus)+" value "+str(value))
	SettingsManager.set_value("Volume", buses_names[0], value)
	AudioServer.set_bus_volume_db(bus,linear_to_db(value))
