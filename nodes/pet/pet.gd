class_name Pet
extends CharacterBody2D

@export var pet_name : String = "tas" :
	set(value):
		pet_name = value
		change_sprite()

@onready var sprite : Sprite2D = $Sprite
@export var stats : PetStats

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

var SPEED = 100

func _physics_process(_delta):

	return;
	
	var direction = 3 #randi() % 5
	var directionVector = Vector2.ZERO 
		
	match direction:
		1: directionVector = Vector2.UP
		2: directionVector = Vector2.DOWN
		3: directionVector = Vector2(-2,1) # Vector2.LEFT
		4: directionVector = Vector2.RIGHT

	if direction:
		self.velocity = directionVector * SPEED
	else:
		self.velocity = Vector2.ZERO
		
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	SPEED = 100 + randi() % 21
	
	change_sprite()
	animationPlayer.play("walk")
	
	loadFromSavestate();
	
# loadPetDataFromSavestate
func loadFromSavestate():
	stats = PetStats.new();
	
# Change the sprite according to name
func change_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")

