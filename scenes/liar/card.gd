class_name Card
extends IsometricObject

const movement_speed = 1.00 / 1.5
@export var number: int
@export var color: String
@export var facing: Constants.FACING

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

## If the number and color is show
var reveal: bool = false 
var user:int=-1;


func _ready() -> void:
	area_2d.input_event.connect(handle_interaction)
	update_sprite()
	pass


func _to_string() -> String:
	return "{0} {1}".format([color, number])


func handle_interaction(viewport: Node, event: InputEvent, shape_idx: int):
	if event is not InputEventScreenTouch:
		return;
		
	if user==0:
		animation_player.play("idle")
		
	print(event)

func show_card_sprite():
	#self.sprite = Sprite2D.new()
	#self.add_child(sprite)
	
	update_sprite()


func set_facing(facing: Constants.FACING):
	self.facing = facing
	update_sprite()


func set_reveal(value: bool):
	self.reveal = value

	update_sprite()


func update_sprite():
	
	if not sprite_2d:
		print("no sprite")
		return
	
	sprite_2d.frame=0
	var frame_cords_x=0

	if self.reveal:
		sprite_2d.texture = load("res://resources/sprites/cards/" + color + ".png")
		sprite_2d.hframes = 10
		sprite_2d.vframes = 2
		frame_cords_x=self.number
	else:
		print(self)
		sprite_2d.texture = load("res://resources/sprites/cards/white.png")
		sprite_2d.hframes = 1
		sprite_2d.vframes = 2

	# Set facing of card
	match self.facing:
		Constants.FACING.DOWN:
			rotation_degrees = 0
			sprite_2d.frame_coords = Vector2i(frame_cords_x, 0)
		Constants.FACING.UP:
			rotation_degrees = 180
			sprite_2d.frame_coords = Vector2i(frame_cords_x, 0)
		Constants.FACING.RIGHT:
			rotation_degrees = 0
			sprite_2d.frame_coords = Vector2i(frame_cords_x, 1)
		Constants.FACING.LEFT:
			rotation_degrees = 180
			sprite_2d.frame_coords = Vector2i(frame_cords_x, 1)
