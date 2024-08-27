extends State
class_name FollowState

@export var target : Node2D
@export var animation : AnimationPlayer
@export var navigation : NavigationNode

## Logic for the entrance of the state
func enter(): 
	if not navigation: 
		push_warning("no navigation set on follow state")
		return
	
	if target:
		navigation.calculate_path_to(navigation.tilemap.get_coordinates_from_position(target.global_position))
	
	navigation.requested.connect(step)
	navigation.finished.connect(finish)

func tick_process():
	
	if not target:
		return
		
	navigation.calculate_path_to(navigation.tilemap.get_coordinates_from_position(target.global_position))
	navigation.step()
	

func step(new_coordinates : Vector2i):
	navigation.step_node_to(get_parent().get_parent(),new_coordinates)

func finish():
	pass
