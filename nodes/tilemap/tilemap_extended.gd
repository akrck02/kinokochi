extends Node2D
class_name TileMapExtended

@onready var layers_container = $Layers
var layers : Array
@onready var grid_area_scene = preload("res://nodes/grid_area/grid_area.tscn");

# On ready 
func _ready():
	
	if layers_container == null:
		push_warning("A layer container called 'Layers' must be created as child of an ExtendedTileMap, creating automatically to assure the correct execution")
		layers_container = Node2D.new()
		layers_container.name = "Layers"
		add_child(layers_container)
		
	var children = layers_container.get_children()
	layers = children.filter(filter_tilemap_layer)

# Filter tilemap layer
func filter_tilemap_layer(node : Node) -> bool:
	return node is TileMapLayer

# Get the position inside de grid
func get_tiled_position(origin : Vector2) -> Vector2:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return origin
	
	return layers[0].map_to_local(get_coordinates_from_position(origin))
	
# Get coordinates from position
func get_coordinates_from_position(origin : Vector2) -> Vector2:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return Vector2.ZERO
	
	return layers[0].local_to_map(origin)

# Get position from coordinates
func get_position_from_coordinates(coords : Vector2) -> Vector2:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return Vector2.ZERO
	
	return layers[0].map_to_local(coords)

# Get if a n object can be placed
func can_object_be_placed_on_tile(node : Node2D, coords : Vector2) -> bool:
	var collisions = get_collisions_on_tile(coords)
	collisions.erase(node.get_index())
	return collisions.is_empty()

# Get all the nodes on one tile
func get_collisions_on_tile(coords : Vector2) -> Dictionary:
	
	var detector = grid_area_scene.instantiate()
	detector.visible = true
	detector.global_position = get_position_from_coordinates(coords)
	add_child(detector)
	var collisions = detector.collisions
	#remove_child(detector)	

	return collisions
