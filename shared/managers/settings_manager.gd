extends Node
const settings_path="res://settings.cfg"
var config = ConfigFile.new()
@onready var response=config.load(settings_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	if !FileAccess.file_exists(settings_path):
		config.set_value("settings","volume", 1)
		config.set_value("settings","outline", true)
		config.save(settings_path)
	else: set_volume(config.get_value("settings","volume"))

func set_value(section,key,value):
	config.set_value(section,key,value)
	config.save(settings_path)

func get_value(section, key):
	return config.get_value(section, key)



func set_volume(value : float):
	SettingsManager.set_value("settings","volume",value)
	var bus_index=AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
	
