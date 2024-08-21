class_name Card
extends Node2D
var number:int;
var color_name:String;
var sprite:Sprite2D
const movement_speed = 1.00/1.5;
const length=40;

func _init(color_name:String,number:int) -> void:
	self.number=number
	self.color_name=color_name	
func _to_string() -> String:
	return "{0} of {1}".format([number,color_name])
	
func _ready() -> void:
	pass
	
func show_card_sprite():
	self.sprite=Sprite2D.new()
	self.add_child(sprite)
	update_sprite()
	
func cartesian_to_isometric(x:int,y:int):
	var screen_pos=Vector2()
	screen_pos.x=(x-y)*length
	screen_pos.y=((x+y)/2)*length
	return screen_pos
	
func move(x:int,y:int):
	self.position=cartesian_to_isometric(x,y)
	
func update_sprite():
	if not sprite:
		return;
	sprite.texture=load("res://resources/sprites/cards/"+color_name+".png")
	sprite.hframes=10
	sprite.frame_coords=Vector2i(self.number,0)
