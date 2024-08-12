@tool
class_name Pet
extends CharacterBody2D

@export var pet_name : String = "foxy" :
	set(value):
		pet_name = value
		change_sprite()

@onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	change_sprite()
	
# Change the sprite according to name
func change_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")

