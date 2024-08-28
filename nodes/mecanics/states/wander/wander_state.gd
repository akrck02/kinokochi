extends State
class_name WanderState

@export var animation : AnimationPlayer
@export var navigation : NavigationNode

## Logic for the entrance of the state
func enter(): 
	animation.play("RESET")
	calculate_next_route()
	navigation.requested.connect(move_along_path)


func tick():
	navigation.step()

func calculate_next_route():
	if navigation.tilemap == null :
		return 
		
	navigation.calculate_current_coordinates()
	var new_coordinates = Vector2i(navigation.coordinates.x, navigation.coordinates.y)
	new_coordinates.x += randi_range(-5,5)
	new_coordinates.y += randi_range(-3,3)
	navigation.calculate_path_to(new_coordinates)


func move_along_path(new_coordinates : Vector2i):
	navigation.step_node_to(actor,new_coordinates)
