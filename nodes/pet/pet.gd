# @tool
class_name Pet
extends CharacterBody2D

@export var pet_name : String = "foxy" :
	set(value):
		pet_name = value
		change_sprite()

@onready var sprite : Sprite2D = $Sprite
@export var stats : PetStats

const SPEED = 100

func _physics_process(_delta):
	
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var direction = randi() % 5
	var directionVector = Vector2.ZERO 
		
	match direction:
		1: directionVector = Vector2.UP
		2: directionVector = Vector2.DOWN
		3: directionVector = Vector2.LEFT
		4: directionVector = Vector2.RIGHT

	if direction:
		self.velocity = directionVector * SPEED
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

