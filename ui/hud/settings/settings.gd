extends Control
@onready var exit_button : Button = $Scroll/Margin/Controls/ExitButton
@onready var general_volume_h_slider: HSlider = $Scroll/Margin/Controls/VolumeControls/GeneralVolumeHSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize values from settings
	general_volume_h_slider.value=SettingsManager.get_value("Volume", "General")
	exit_button.pressed.connect(exit)
	general_volume_h_slider.value_changed.connect(change_volume.bind(0))

func exit():
	TouchInput.context = Game.Context.Camera
	set_visible(false)

func change_volume(value:float, bus:int):
	var buses_names=["General"]
	SettingsManager.set_value("Volume", buses_names[0], value)
	AudioServer.set_bus_volume_db(bus,linear_to_db(value))
