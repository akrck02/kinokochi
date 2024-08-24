class_name Npc
extends CharacterBody2D

# Pet data
@export var pet_name : String = "tas"

# Visuals
@onready var sprite : Sprite2D = $Sprite

# Movement
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
@export var movement_speed = 1.00/1.5;
var moving = false

# Interactions
@onready var area_2d : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_savestate();
	update_sprite()

	SignalDatabase.tick_reached.connect(tick_update)

	# Interactions
	area_2d.input_event.connect(handle_interaction)
	
	# Set outline based on config file
	animation_player.play("idle")

# load pet data from savestate
func load_from_savestate():
	pass
	
# Change the sprite according to name
func update_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")

# Handle interaction
func handle_interaction(_viewport: Node, event: InputEvent, _shape_idx: int):
	
	if event is not InputEventScreenTouch:
		return;
		
	handle_touch(event)
	
# Handle touch interaction
func handle_touch(event : InputEventScreenTouch):
	
	if not event.double_tap:
		return

# This function will be called every tick
func tick_update():
	automatic_movement()

# Automatic movement
func automatic_movement():
	
	if moving: 
		return
	
	var direction = randi() % 7
	move(direction)


# Move the character
func move(direction : int):

	moving = true
	var coords = SceneManager.current_tilemap.get_coordinates_from_position(global_position)
		
	match direction:
		1: coords.x -= 1   # Left
		2: coords.x += 1 # Right
		3: coords.y -= 1  # Down
		4: coords.y += 1   # Up		
	
	if SceneManager.current_tilemap.can_object_be_placed_on_tile(self, coords):
		return
	
	var new_position = SceneManager.current_tilemap.get_position_from_coordinates(coords)
	tween = create_tween()
	tween.tween_property(self, NodeExtensor.GLOBAL_POSITION_PROPERTIES, new_position, .15).set_trans(Tween.TRANS_SINE)
	moving = false

# Interact
func interact():
	pass
