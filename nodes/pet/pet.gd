@tool
class_name Pet
extends CharacterBody2D

@export var pet_name : String = "foxy" :
	set(value):
		pet_name = value
		change_sprite()

@onready var sprite : Sprite2D = $Sprite
@export var stats : PetStats

const SPEED = 60

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	print(direction)
	
	if direction:
		self.velocity = direction * SPEED
	else:
		self.velocity = Vector2.ZERO
		
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	change_sprite()
	loadFromSavestate();
	
# loadPetDataFromSavestate
func loadFromSavestate():
	stats = PetStats.new();
	
# Change the sprite according to name
func change_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")

