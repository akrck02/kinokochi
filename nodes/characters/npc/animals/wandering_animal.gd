extends CharacterBody2D

## Runtime guard
@onready var runtime_guard : RuntimeGuard = RuntimeGuard.for_node(name)

# Dependancy injection
@export var tilemap : TileMapExtended 

# State management
@onready var states : StatesNode = $StatesNode

# Navigation
@onready var navigation : NavigationNode = $Navigation
@onready var follow_area : Area2D = $FollowArea

## Initial logic of the node
func _ready():
	
	runtime_guard.register_parameter("tilemap", tilemap)
	if not runtime_guard.calculate_if_runtime_must_be_enabled():
		Nodes.stop_node_logic_process(self)
		return
	
	navigation.tilemap = tilemap
