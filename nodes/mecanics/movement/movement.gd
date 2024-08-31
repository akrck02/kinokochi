extends Node2D
class_name Movement

## Dependency injection
var dependencies : DependencyDatabase = DependencyDatabase.for_node("Movement")

# Dependency injection
@export var tilemap : TileMapExtended

# Standard procedural animation
@export var speed = 1.5
@onready var tween : Tween

## Check if tilmap is setup
func is_movement_ready() -> bool :
	dependencies.add("tilemap", tilemap)
	return dependencies.check()
	

## Tween node between coordinates
func step_node_to(node : Node2D, new_coordinates : Vector2i) -> void:
	
	if not is_movement_ready():
		return
	
	tween = create_tween()
	var new_global_position = tilemap.get_global_position_from_coordinates(new_coordinates)
	tween.tween_property(node, NodeProperties.GlobalPosition, new_global_position, 1.00/speed).set_trans(Tween.TRANS_SINE)
	await tween.finished
