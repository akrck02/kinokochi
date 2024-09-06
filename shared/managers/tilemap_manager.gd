extends Node

## Registered tilemaps
var tilemaps : Dictionary = {}


## Register tilemap
func register(name : String, reset : bool) -> void:
	tilemaps[name] = {}


## Get coordinates from global position
func get_coordinates_from_position(origin : Vector2) -> Vector2i:
	return Vector2i.ZERO


## Get local position from coordinates
func get_position_from_coordinates(coordinates : Vector2) -> Vector2:
	return Vector2.ZERO


## Get if an object can be placed
func is_free(coordinates : Vector2) -> bool:
	return true


## Get all the nodes on one tile
## FIXME collisions are faster than the light (?) NOT BEING DETECTED
func get_collisions_on_tile(coordinates : Vector2) -> Dictionary:
	return {}
