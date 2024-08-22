## Class that contains methods to move in a isometric map
extends Node2D
class_name IsometricObject

## Space between positions
const length = 40
@export var x:int
@export var y:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _cartesian_to_isometric(x: int, y: int):
	var cartesian_pos = Vector2(x, y)
	var isometric_pos = Vector2()
	isometric_pos.x = (cartesian_pos.x - cartesian_pos.y) * length
	isometric_pos.y = ((cartesian_pos.x + cartesian_pos.y) / 2) * length
	self.x=isometric_pos.x
	self.y=isometric_pos.y
	return isometric_pos


## Changes the object position but using isometric coordinates
func move(x: int, y: int):
	self.position = _cartesian_to_isometric(x, y)
