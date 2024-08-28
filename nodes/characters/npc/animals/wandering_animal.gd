extends CharacterBody2D

@onready var states : StatesNode = $StatesNode
@onready var navigation : NavigationNode = $Navigation
@onready var follow_area : Area2D = $FollowArea

func _physics_process(_delta: float):
	navigation.set_tilemap(SceneManager.tilemap)
