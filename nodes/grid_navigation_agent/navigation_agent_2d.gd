extends NavigationAgent2D
class_name  GridNavigationAgent2D

@export var diagonal_movement_allowed : bool = false

## Get the navigation path on grid
func get_grid_navigation_path(tilemap : TileMapExtended, destiny_coordinates : Vector2) -> Array[Vector2i]:
	
	if tilemap == null:
		push_warning("Tilemap is not set on navigation agent, so no navigation operations will be performed")
		return []
	
	self.target_position = tilemap.get_global_position_from_coordinates(destiny_coordinates)
	var _next = get_next_path_position()
	var current_path = get_current_navigation_path()
	
	var current_navigation_path : Array[Vector2i] = []
	for path_position in current_path:
		current_navigation_path.append(tilemap.get_coordinates_from_position(path_position))
	
	if not diagonal_movement_allowed:
		current_navigation_path = get_path_without_diagonals(current_navigation_path)

	return current_navigation_path;

## Get the path without diagonal directions
func get_path_without_diagonals(current_navigation_path :  Array[Vector2i]) -> Array[Vector2i]:
	
	var new_path : Array[Vector2i] = []
	var i : int = 0
	
	for coordinates in current_navigation_path:
		
		if i == current_navigation_path.size() - 1:
			new_path.append(current_navigation_path[i])
			return new_path
		
		var next = current_navigation_path[i + 1]
		new_path.append(current_navigation_path[i])
		
		i += 1
	
	return new_path
