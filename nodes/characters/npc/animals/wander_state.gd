extends State
class_name WanderState

@export var animation : AnimationPlayer
@export var navigation : NavigationNode

## Logic for the entrance of the state
func enter(): 
	navigation.debug = true
	animation.play("idle")
