## Class that contains methods to move in a isometric map
extends Node2D
class_name IsometricObject

const length=40
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _cartesian_to_isometric(x:int,y:int):
	var screen_pos=Vector2()
	screen_pos.x=(x-y)*length
	screen_pos.y=((x+y)/2)*length
	return screen_pos

# Changes the object position
func move(x:int,y:int):
	self.position=_cartesian_to_isometric(x,y)
