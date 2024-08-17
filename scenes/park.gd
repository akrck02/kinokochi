extends Node2D

@onready var camera : Camera2D = $Camera2D
@onready var pet : Pet = $Pet

func _physics_process(_delta):
	camera.position = pet.position
