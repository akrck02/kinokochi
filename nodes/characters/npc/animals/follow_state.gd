extends State
class_name FollowState

@export var target : Node2D
@export var body : Node2D
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

## Logic for the entranec of the state
func exit():
	
	if not navigation: 
		push_warning("no navigation set on follow state")
		return
	
	if navigation.requested.is_connected(step):
		navigation.requested.disconnect(step)
	
	if navigation.finished.is_connected(finish):
		navigation.finished.disconnect(finish)

## Process a game tick
func tick_process():
	
	if not target:
		return
		
	navigation.calculate_path_to(navigation.tilemap.get_coordinates_from_position(target.global_position))
	navigation.step()
	navigation.step_node_to(body, navigation.coordinates)

## Step
func step(new_coordinates : Vector2i):
	if not body:
		return
	
	navigation.step_node_to(body, new_coordinates)

# Finish the movement
func finish():
	animation.play("idle")
