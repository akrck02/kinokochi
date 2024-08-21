class_name Card
extends IsometricObject

const movement_speed = 1.00 / 1.5
@onready var sprite: Sprite2D = $Sprite2D
@export var number: int
@export var color: String

enum FACING { UP, DOWN, LEFT, RIGHT }
@export var facing: FACING


func _ready() -> void:
	update_sprite()
	pass


func _to_string() -> String:
	return "{0} of {1}".format([number, color])


func show_card_sprite():
	self.sprite = Sprite2D.new()
	self.add_child(sprite)
	update_sprite()


func update_sprite():
	if not sprite:
		return
	sprite.texture = load("res://resources/sprites/cards/" + color + ".png")
	sprite.hframes = 10
	sprite.vframes = 2

	# Set facing of card
	match self.facing:
		FACING.UP:
			rotation_degrees = 0
			sprite.frame_coords = Vector2i(self.number, 0)
		FACING.DOWN:
			rotation_degrees = 180
			sprite.frame_coords = Vector2i(self.number, 0)
		FACING.LEFT:
			rotation_degrees = 0
			sprite.frame_coords = Vector2i(self.number, 1)
		FACING.RIGHT:
			rotation_degrees = 180
			sprite.frame_coords = Vector2i(self.number, 1)
