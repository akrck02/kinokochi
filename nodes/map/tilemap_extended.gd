extends Node2D
class_name TileMapExtended

@onready var layers_container = $Layers
@onready var grid_area_scene = preload("res://nodes/map/grid_area/grid_area.tscn");
var layers : Array[TileMapLayerExtended]

## On ready 
func _ready():
	setup_layer_container()
	setup_layers()

## Create a layer container if not present
func setup_layer_container():
	if layers_container != null:
		return
		
	push_warning("A layer container called 'Layers' must be created as child of an ExtendedTileMap, creating automatically to assure the correct execution")
	layers_container = Node2D.new()
	layers_container.name = "Layers"
	add_child(layers_container)

## Get the layers
func setup_layers():
	var children = layers_container.get_children()
	for node in children:
		if node is TileMapLayerExtended:
			layers.append(node as TileMapLayerExtended)

## Filter tilemap layer
func filter_tilemap_layer_extended(node : Node) -> bool:
	return node is TileMapLayerExtended

## Get the position inside de grid
func get_tiled_position(origin : Vector2) -> Vector2:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return origin
	
	return layers[0].map_to_local(get_coordinates_from_position(origin))

## Get coordinates from local position
func get_coordinates_from_position(local_origin : Vector2) -> Vector2i:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return Vector2.ZERO
	
	return layers[0].local_to_map(local_origin)

## Get coordinates from global position
func get_coordinates_from_global_position(global_origin : Vector2) -> Vector2i:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return Vector2.ZERO
	
	return layers[0].local_to_map(to_local(global_origin))

## Get local position from coordinates
func get_position_from_coordinates(coords : Vector2) -> Vector2:
	
	if layers.is_empty():
		push_warning("tile layer not asigned")
		return Vector2.ZERO
	
	return layers[0].map_to_local(coords)

## Get global position from coordinates
func get_global_position_from_coordinates(coords : Vector2) -> Vector2:
	return self.to_global(get_position_from_coordinates(coords))

## Get if an object can be placed
func can_object_be_placed_on_tile(node : Node2D, coords : Vector2) -> bool:
	var collisions = get_collisions_on_tile(coords)
	collisions.erase(node.get_index())
	return collisions.is_empty()

## Get all the nodes on one tile
## FIXME collisions are faster than the light (?) NOT BEING DETECTED
func get_collisions_on_tile(coords : Vector2) -> Dictionary:
	
	var detector = grid_area_scene.instantiate()
	detector.visible = true
	detector.global_position = to_global(get_position_from_coordinates(coords))
	add_child(detector)
	var collisions = detector.collisions
	remove_child(detector)

	return collisions
