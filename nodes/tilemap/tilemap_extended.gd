extends Node2D
class_name TileMapExtended

var layers : Array

# On ready 
func _ready():
	var children = get_children()
	layers = children.filter(filter_tilemap_layer)

# Filter tilemap layer
func filter_tilemap_layer(node : Node) -> bool:
	return node is TileMapLayer

# Get the position inside de grid
func get_tiled_position(origin : Vector2) -> Vector2:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return origin
	
	return layers[0].map_to_local(layers[0].local_to_map(origin))
	
# Get  if a n object can be placed
func can_object_be_placed() -> bool:
	return true;
