class_name Pet
extends CharacterBody2D

@export var pet_name : String = "tas"
@export var stats : PetStats
@onready var sprite : Sprite2D = $Sprite
@onready var pointLight : PointLight2D = $PointLight2D

# Movement
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
@export var movement_speed = 1.00/1.5;
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_savestate();
	update_sprite()
	SignalDatabase.tick_reached.connect(tick_update)
	animationPlayer.play("idle")
	SignalDatabase.night_started.connect(set_night)
	SignalDatabase.day_started.connect(set_day)

# loadPetDataFromSavestate
func load_from_savestate():
	stats = PetStats.new();
	
# Change the sprite according to name
func update_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")

# This function will be called every tick
func tick_update():
	automatic_movement()

# Automatic movement
func automatic_movement():
	
	if moving: 
		return
	
	moving = true
	var direction = randi() % 7
	var length = 40 
	var new_position = Vector2.ZERO 
		
	match direction:
		1: new_position = length * (Vector2.UP * 0.5 + Vector2.LEFT)    # Left
		2: new_position = length * (Vector2.UP * 0.5 + Vector2.RIGHT)   # Up
		3: new_position = length * (Vector2.DOWN * 0.5 + Vector2.LEFT)  # Down
		4: new_position = length * (Vector2.DOWN * 0.5 + Vector2.RIGHT) # Right

	# Check future collisions
	ray.target_position = new_position
	ray.force_raycast_update()
	
	# If a collision will happen, stop
	if not ray.is_colliding() and new_position != Vector2.ZERO:
		animationPlayer.play("walk")
		tween = create_tween()
		tween.tween_property(self, NodeExtensor.POSITION_PROPERTIES, position + new_position, movement_speed).set_trans(Tween.TRANS_SINE)
		await tween.finished
		tween.kill()
		animationPlayer.play("idle")
		
	moving = false
	

# Prepare the visuals for nighttime
func set_night() : 
	pointLight.show()

# Prepare the visuals for daytime
func set_day() : 
	pointLight.hide()
