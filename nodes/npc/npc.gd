class_name Npc
extends CharacterBody2D

# Pet data
@export var pet_name : String = "tas"

# Visuals
@onready var sprite : Sprite2D = $Sprite

# Movement
@onready var navigation_agent : GridNavigationAgent2D = $GridNavigationAgent2D
@export var target_coordinates : Vector2i 

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween

var navigation_path : Array[Vector2i] = []
var path_line : Line2D = null
var moving = false
var coordinates

# Interactions
@onready var area_2d : Area2D = $Area2D

## Called when the node enters the scene tree for the first time.
func _ready():
	
	# Signal connection
	SignalDatabase.screen_touch_double_tap.connect(move_test)
	SignalDatabase.tick_reached.connect(tick_update)
	area_2d.input_event.connect(handle_interaction)
	
	# Setup the npc data
	load_from_savestate();
	update_sprite()
	
	# Start animations
	animation_player.play("idle")

## load pet data from savestate
func load_from_savestate():
	pass
	
## Change the sprite according to name
func update_sprite():
	if not sprite:
		return;
	
	sprite.texture = load("res://resources/sprites/pets/" + pet_name + ".png")

## Handle interaction
func handle_interaction(_viewport: Node, event: InputEvent, _shape_idx: int):
	
	if event is not InputEventScreenTouch:
		return;
		
	handle_touch(event)
	
## Handle touch interaction
func handle_touch(event : InputEventScreenTouch):
	
	if not event.double_tap:
		return

## This function will be called every tick
func tick_update():
	calculate_current_coordinates()
	snap_to_grid()
	automatic_movement()

## Snap the npc to grid
func snap_to_grid():
	var snap_position =  SceneManager.current_tilemap.to_global(SceneManager.current_tilemap.get_position_from_coordinates(coordinates));
	if global_position != snap_position:
		global_position = snap_position

## Calculate current coordinates
func calculate_current_coordinates():
	coordinates = SceneManager.current_tilemap.get_coordinates_from_position(SceneManager.current_tilemap.to_local(global_position))

## Automatic movement
func automatic_movement():

	if navigation_agent.is_navigation_finished() or navigation_path.is_empty():
		animation_player.play("idle")
		return
	
	var next_coordinates = navigation_path.front()
	if next_coordinates == null:
		print("position not found")
		return
	
	move_towards_in_grid(next_coordinates)
	navigation_path.pop_front()

## Test click movement
func move_test(input: InputData) -> void:
	calculate_current_coordinates()
	var click_coordinates : Vector2i = SceneManager.current_tilemap.get_coordinates_from_position(input.get_current_global_position(get_viewport()))
	navigation_path = navigation_agent.get_grid_navigation_path(SceneManager.current_tilemap, click_coordinates) 
	
	if path_line != null:
		SceneManager.current_tilemap.remove_child(path_line)
		
	path_line = Line2D.new()
	path_line.default_color =  Color(1, 1, 1, .5)
	path_line.width = 40
	path_line.z_index = 2
	path_line.antialiased = true
	path_line.joint_mode = Line2D.LINE_JOINT_BEVEL
	for point in navigation_path:  
		path_line.add_point(SceneManager.current_tilemap.get_global_position_from_coordinates(point)) 

	SceneManager.current_tilemap.add_child(path_line)

## Move towards coordinates in grid
func move_towards_in_grid(new_coordinates : Vector2i):
	
	if new_coordinates == null:
		return;
		
	if animation_player.current_animation != "walk":
		animation_player.play("walk")
	
	# if not SceneManager.current_tilemap.can_object_be_placed_on_tile(self, coords):
		# return
	
	moving = true
	var new_position = SceneManager.current_tilemap.get_position_from_coordinates(new_coordinates)
	tween = create_tween()
	tween.tween_property(self, NodeExtensor.GLOBAL_POSITION_PROPERTIES, new_position, 1.00/1.5).set_trans(Tween.TRANS_SINE)
	await tween.finished
	moving = false


## Calculate next direction
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


## Move the character
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
	
	# if not SceneManager.current_tilemap.can_object_be_placed_on_tile(self, coords):
		# return

	var new_position = SceneManager.current_tilemap.get_position_from_coordinates(coordinates)
	tween = create_tween()
	tween.tween_property(self, NodeExtensor.GLOBAL_POSITION_PROPERTIES, new_position, 1.00/1.5).set_trans(Tween.TRANS_SINE)
	await tween.finished

## Interact
func interact():
	pass
