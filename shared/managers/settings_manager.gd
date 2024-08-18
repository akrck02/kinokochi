extends Node
const settings_path="user://kinokoro.esettings.cfg"
var config = ConfigFile.new()
@onready var response=config.load(settings_path)

var default_settings={"Volume":{"General":1},"Character":{"Outline":false}}

# Called when the node enters the scene tree for the first time.
func _ready():
	if !FileAccess.file_exists(settings_path):
		config.set_value("Volume","General", 1)
		config.set_value("Character","Outline", true)
		config.save(settings_path)
		
	elif !check_structure():
		config.clear()
		set_default_values()
	
	else: 
		set_volume_bus(0,config.get_value("Volume","General"))
		
func set_default_values():
	for section in default_settings.keys():
		for key in default_settings[section].keys():
			config.set_value(section, key, default_settings[section][key])
			
	config.save(settings_path)


# Check if the structure of the settings match the default settings structure
func check_structure()->bool:
	var default_sections=default_settings.keys()
	var config_file_sections=Array(config.get_sections())
	default_sections.sort()
	config_file_sections.sort()
	
	# Check if sections match
	if default_sections!=config_file_sections:
		return false
	
	# Check if keys match
	for x in config_file_sections:
		var config_keys=Array(config.get_section_keys(x))
		var default_keys=default_settings[x].keys()
		config_keys.sort()
		default_keys.sort()
		if config_keys!=default_keys:
			return false
		
	return true

func set_value(section:String,key:String,value:Variant):
	config.set_value(section,key,value)
	config.save(settings_path)

func get_value(section:String, key:String):
	return config.get_value(section, key)

func set_volume_bus(bus:int, value : float):
	SettingsManager.set_value("Volume","General",value)
	AudioServer.set_bus_volume_db(bus,linear_to_db(value))
