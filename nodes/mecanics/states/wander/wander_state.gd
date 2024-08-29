extends State
class_name WanderState

@export var animation : AnimationPlayer
@export var navigation : NavigationNode
@export var movement : Movement

var tilemap : TileMapExtended
var navigation_data : GridNavigationData

func _ready() -> void:
	
	runtime_guard.register_parameter("animation", animation)
	runtime_guard.register_parameter("navigation", navigation)
	runtime_guard.register_parameter("movement", movement)

	if runtime_guard.calculate_if_runtime_must_be_enabled():
		Nodes.stop_node_logic_process(self)
		enabled = false
		return


## Logic for the entrance of the state
func enter(): 
	animation.play("RESET")
	
	runtime_guard.register_parameter("tilemap", tilemap)
	if runtime_guard.calculate_if_runtime_must_be_enabled():
		return 
		
	navigation_data = calculate_next_route()


func tick():
	move_along_path()


func calculate_next_route() -> GridNavigationData:
		
	navigation_data = navigation.calculate_current_coordinates()
	if navigation_data == null:
		return
	
	var new_coordinates = navigation_data.current_coordinates
	new_coordinates.x += randi_range(-5,5)
	new_coordinates.y += randi_range(-3,3)
	return navigation.calculate_path_to(new_coordinates)


func move_along_path():	
	var new_coordinates = navigation.next(navigation_data)
	if new_coordinates == null:
		return
	
	movement.step_node_to(actor, new_coordinates)
