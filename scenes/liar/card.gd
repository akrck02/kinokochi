class_name Card
extends IsometricObject


var number:int;
var color_name:String;
const movement_speed = 1.00/1.5;
@onready var sprite: Sprite2D = $Sprite2D
@export var x:int;
@export var y:int;

func _init(color_name:String,number:int) -> void:
	self.number=number
	self.color_name=color_name
	move(x,y)
	
func _to_string() -> String:
	return "{0} of {1}".format([number,color_name])
	
func _ready() -> void:
	pass
	
func show_card_sprite():
	self.sprite=Sprite2D.new()
	self.add_child(sprite)
	update_sprite()
	
	
func update_sprite():
	if not sprite:
		return;
	sprite.texture=load("res://resources/sprites/cards/"+color_name+".png")
	sprite.hframes=10
	sprite.frame_coords=Vector2i(self.number,0)
