extends Node2D
class_name NavigationNode

# Signals
signal finished
signal requested(destiny : Vector2i)

# Debug parameters 
@export var debug : bool = false 
@export var color : Color = Color(randf_range(0.5,1), randf_range(0.5,1), randf_range(0.5,1), 1);
@export var tilemap : TileMapExtended = null

# Standard navigation params
@onready var navigation_agent : GridNavigationAgent2D = $GridNavigationAgent2D
@onready var coordinates : Vector2i = Vector2.ZERO
var navigation_path : Array[Vector2i] = []
var path_line : Line2D = null

# Standard procedural animation
@onready var tween : Tween

func _ready() -> void:
	print_tree()

## Set up the tilemap
func set_tilemap(new_tilemap : TileMapExtended):
	tilemap = new_tilemap
	calculate_current_coordinates()


## Called once per update
func _physics_process(_delta: float):
	if tilemap:
		calculate_current_coordinates()


## Calculate current coordinates
func calculate_current_coordinates():
	coordinates = tilemap.get_coordinates_from_position(tilemap.to_local(global_position))


## Get global position from current coordinates
func get_current_global_position() -> Vector2:
	return tilemap.get_global_position_from_coordinates(coordinates)


## Calculate the navigation path 
func calculate_path_to(destiny_coordinates : Vector2i):
	
	if not navigation_agent:
		return
	
	_remove_debug_line()
	navigation_path = navigation_agent.get_grid_navigation_path(tilemap, destiny_coordinates) 
	_draw_debug_line()
	return navigation_path

## Request step to the next path coordinates
func step():

	if navigation_agent.is_navigation_finished() or navigation_path.is_empty():
		finished.emit()
		return
	
	var next_coordinates = navigation_path.front()
	if next_coordinates == null:
		print("position not found")
		return
	
	requested.emit(next_coordinates)
	navigation_path.pop_front()


## Draw a line in the tilemap (only in debug mode)
func _draw_debug_line():
	
	if not debug:
		return
	
	path_line = Line2D.new()
	path_line.default_color = color
	path_line.width = 1
	path_line.z_index = 2
	path_line.antialiased = true
	path_line.joint_mode = Line2D.LINE_JOINT_BEVEL
	
	for point in navigation_path:  
		path_line.add_point(SceneManager.current_tilemap.get_global_position_from_coordinates(point)) 

	tilemap.add_child(path_line)

## Remove the debug line from the tilemap (only in debug mode)
func _remove_debug_line():
	
	if not debug or path_line == null:
		return 
	
	tilemap.remove_child(path_line)


## Snap the parent to grid
func snap_to_grid():
	var snap_position = get_current_global_position()
	if get_parent().global_position != snap_position:
		get_parent().global_position = snap_position

## Tween node between coordinates
func step_node_to(node : Node2D, new_coordinates : Vector2i):
	var speed = 1.00/1.5
	tween = create_tween()
	tween.tween_property(node, NodeExtensor.GLOBAL_POSITION_PROPERTIES, tilemap.get_position_from_coordinates(new_coordinates), speed).set_trans(Tween.TRANS_SINE)
	await tween.finished
