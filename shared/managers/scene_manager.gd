extends Node

func _ready():
	SignalDatabase.scene_change_requested.connect(change_scene)

func change_scene(name : String):
	if !name.begins_with("res://"):
		name = Constants.SCENE_PATH + name + ".tscn"
	
	var canvas = get_tree().get_root().get_node("/root/Canvas")
	var current_scenes = canvas.get_children()
	for past_scene in current_scenes:
		past_scene.queue_free()
		
	# find the targeted scene
	var error = ResourceLoader.load_threaded_request(name)
	
	# check for errors
	if error != OK:
		# handle your error 
		print("error occured while getting the scene " + name)
		return

	var progress = [0]
	while progress[0] < 1:
		ResourceLoader.load_threaded_get_status(name, progress)
	
	# adding scene to the root
	var scene = ResourceLoader.load_threaded_get(name).instantiate()
	canvas.call_deferred("add_child", scene)
