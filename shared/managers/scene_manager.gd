extends Node

var current_tilemap : TileMapExtended

func _ready():
	SignalDatabase.scene_change_requested.connect(change_scene)

# change scene with progress
func change_scene(scene_name : String):
	
	# Set up the path
	if !scene_name.begins_with("res://"):
		scene_name = Constants.SCENE_PATH + scene_name + ".tscn"
	
	# Get canvas layer
	var canvas = get_tree().get_root().get_node("/root/Canvas")
	var current_scenes = canvas.get_children()
	for past_scene in current_scenes:
		past_scene.queue_free()
		
	# Find the targeted scene
	var error = ResourceLoader.load_threaded_request(scene_name)
	
	# check for errors
	if error != OK:
		# handle your error 
		print("error occured while getting the scene " + scene_name)
		return

	var progress = [0]
	while progress[0] < 1:
		ResourceLoader.load_threaded_get_status(scene_name, progress)
	
	# adding scene to the root
	var scene : Node = ResourceLoader.load_threaded_get(scene_name).instantiate()
	canvas.add_child(scene)
	
	# Get tilemap if exists
	var tilemap = scene.get_node_or_null("Tilemap")
	if tilemap != null and tilemap is TileMapExtended:
		current_tilemap = tilemap
