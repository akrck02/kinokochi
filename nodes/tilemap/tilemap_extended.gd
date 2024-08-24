extends Node2D
class_name TileMapExtended

@onready var layers_container = $Layers
@onready var grid_area_scene = preload("res://nodes/grid_area/grid_area.tscn");
var layers : Array[TileMapLayer]
var astar : AStarGrid2D = AStarGrid2D.new()
var map_rectangle = Rect2i()

# On ready 
func _ready():
	setup_layer_container()
	setup_layers()
	setup_astar()

# Create a layer container if not present
func setup_layer_container():
	if layers_container != null:
		return
		
	push_warning("A layer container called 'Layers' must be created as child of an ExtendedTileMap, creating automatically to assure the correct execution")
	layers_container = Node2D.new()
	layers_container.name = "Layers"
	add_child(layers_container)

# Get the layers
func setup_layers():
	var children = layers_container.get_children()
	for node in children:
		if node is TileMapLayer:
			layers.append(node as TileMapLayer)

# Setup astar for navigation
func setup_astar():
	
	if layers.is_empty():
		push_warning("tile layer not asigned, cannot setup navigation functions")
		return
	
	var base_layer = layers[0]
	var tilemap_size = base_layer.get_used_rect().end - base_layer.get_used_rect().position
	map_rectangle = Rect2i(Vector2i.ZERO, tilemap_size)
	var tile_size = base_layer.tile_set.tile_size
	
	astar.region = map_rectangle
	astar.cell_size = tile_size
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER	
	astar.update()
		
	for coord_x in tilemap_size.x:
		for coord_y in tilemap_size.y:
			var coords = Vector2i(coord_x, coord_y)
			
			if has_tile_navigation_wall(coords):
				astar.set_point_solid(coords)

# Get if the coordination has a navigation wall 
func has_tile_navigation_wall(coordinates : Vector2i) -> bool:
				
	for layer in layers:
		var tile_data = layer.get_cell_tile_data(coordinates)
		if tile_data and tile_data.get_custom_data("navigation_type") == "wall":
			return true
		
	return false

# Get if point is walkable
func is_point_walkable(origin : Vector2) -> bool:
	var point = get_coordinates_from_position(origin)
	if map_rectangle.has_point(point):
		if not astar.is_point_solid(point):
			return true
	return false
	
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
