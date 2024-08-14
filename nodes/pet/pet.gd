class_name Pet
extends CharacterBody2D

@export var pet_name : String = "tas"
@onready var sprite : Sprite2D = $Sprite
@export var stats : PetStats

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
var SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready():
		
	# var random = RandomNumberGenerator.new()
	# random.randomize()
	
	loadFromSavestate();
	update_sprite()
	animationPlayer.play("walk")
	SignalDatabase.tick_reached.connect(tick_update)

func _physics_process(delta):
	move_and_slide()
	
# loadPetDataFromSavestate
func loadFromSavestate():
	stats = PetStats.new();
	
# Change the sprite according to name
func update_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")


func tick_update():
	automatic_movement()

# Automatic movement
func automatic_movement():
	
	var direction = randi() % 11
	var directionVector = Vector2.ZERO 
		
	match direction:
		1: directionVector = Vector2.UP * 0.5 + Vector2.LEFT    # Left
		2: directionVector = Vector2.UP * 0.5 + Vector2.RIGHT   # Up
		3: directionVector = Vector2.DOWN * 0.5 + Vector2.LEFT  # Down
		4: directionVector = Vector2.DOWN * 0.5 + Vector2.RIGHT # Right

	if direction:
		self.velocity = directionVector * SPEED
	else:
		self.velocity = Vector2.ZERO
		
	
