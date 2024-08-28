extends State
class_name WanderState

@export var animation : AnimationPlayer
@export var navigation : NavigationNode

## Logic for the entrance of the state
func enter(): 
	animation.play("idle")
