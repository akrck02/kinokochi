extends Node

func _ready():
	SignalDatabase.scene_change_requested.connect(change_scene)

func change_scene(name : String):
	
	pass
