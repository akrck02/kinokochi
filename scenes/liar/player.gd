extends Node

class_name Player
var id:int;
var hand:Hand;

func _init(id:int,name:String, hand:Hand) -> void:
	self.id=id
	self.name=name
	self.hand=hand
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
