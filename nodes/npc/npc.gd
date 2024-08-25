class_name Npc
extends CharacterBody2D

# Pet data
@export var pet_name : String = "tas"

# Visuals
@onready var sprite : Sprite2D = $Sprite

# Movement
@export var target : Node2D = null
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
var moving = false
var current_path : Array[Vector2i] = []
var coordinates

# Interactions
@onready var area_2d : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Signal connection
	SignalDatabase.screen_touch_double_tap.connect(move_test)
	SignalDatabase.tick_reached.connect(tick_update)
	area_2d.input_event.connect(handle_interaction)
	
	# Setup the npc data
	load_from_savestate();
	update_sprite()
	# calculate_current_coordinates()
	
	# Start animations
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
	calculate_current_coordinates()
	automatic_movement()

# Calculate current coordinates
func calculate_current_coordinates():
	coordinates = SceneManager.current_tilemap.get_coordinates_from_position(global_position)

# Automatic movement
func automatic_movement():
	if current_path.is_empty():
		return

	var new_coordinates : Vector2i = current_path.front()
	var target_position : Vector2i = SceneManager.current_tilemap.get_global_position_from_coordinates(new_coordinates)
	
	print("Going to: ")
	print(target_position)
	
	move_towards_in_grid(new_coordinates)
	
	if global_position as Vector2i == target_position:
		print("Arrived at: ")
		print(target_position)
		current_path.pop_front()
		animation_player.play("idle")

# Test click movement
func move_test(input: InputData) -> void:
	var click_position : Vector2i = SceneManager.current_tilemap.to_local(input.get_current_global_position(get_viewport()))
	var local_position  : Vector2i = SceneManager.current_tilemap.to_local(global_position)
	var current_coordinates  : Vector2i = SceneManager.current_tilemap.get_coordinates_from_position(local_position)
	var new_coordinates  : Vector2i = SceneManager.current_tilemap.get_coordinates_from_position(click_position)
	var is_walkable : bool = SceneManager.current_tilemap.is_coordinate_walkable(new_coordinates)
	
	print()
	print("#####################################")
	print("Click on local:")
	print(click_position)
	print("----------------------------------------")
	
	print("NPC coordinates:")
	print(current_coordinates)
	print()
	print("----------------------------------------")
	
	print("Click on coordinates:")
	print(new_coordinates)
	print()
	print("----------------------------------------")
	
	print("Coordinates are walkable:")
	print(is_walkable)
	print()
	print("----------------------------------------")
	
	print("Local position:")
	print(local_position)
	print("----------------------------------------")
	
	if is_walkable:
		current_path = SceneManager.current_tilemap.astar.get_id_path(current_coordinates, new_coordinates).slice(1)
	
	print("Current path")
	print(current_path)
	print("----------------------------------------")

# Move towards coordinates in grid
func move_towards_in_grid(new_coordinates : Vector2i):
	
	if animation_player.current_animation != "walk":
		animation_player.play("walk")
	
	moving = true
	var direction = calculate_next_direction(new_coordinates)
	move(direction)
	moving = false


# Calculate next direction
func calculate_next_direction(new_coordinates : Vector2i) -> MoveEnums.Direction:
	
	if new_coordinates.x > coordinates.x:
		return MoveEnums.Direction.Right
	elif new_coordinates.x < coordinates.x: 
		return MoveEnums.Direction.Left
	elif new_coordinates.y > coordinates.y: 
		return MoveEnums.Direction.Up
	elif new_coordinates.y < coordinates.y: 
		return MoveEnums.Direction.Down

	return MoveEnums.Direction.None


# Move the character
func move(direction : MoveEnums.Direction):
	
	match direction:
		MoveEnums.Direction.Left: 
			coordinates.x -= 1
			sprite.flip_h = false
		MoveEnums.Direction.Right: 
			coordinates.x += 1
			sprite.flip_h = true
		MoveEnums.Direction.Down: 
			coordinates.y -= 1 
			sprite.flip_h = true
		MoveEnums.Direction.Up: 
			coordinates.y += 1   
			sprite.flip_h = false
	
	# if SceneManager.current_tilemap.can_object_be_placed_on_tile(self, coords):
		# return

	var new_position = SceneManager.current_tilemap.get_position_from_coordinates(coordinates)
	tween = create_tween()
	tween.tween_property(self, NodeExtensor.GLOBAL_POSITION_PROPERTIES, new_position, 1.00/1.5).set_trans(Tween.TRANS_SINE)
	await tween.finished	

# Interact
func interact():
	pass
