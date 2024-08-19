class_name Pet
extends CharacterBody2D

@export var pet_name : String = "tas"
@export var stats : PetStats
@onready var sprite : Sprite2D = $Sprite
@onready var point_light : PointLight2D = $PointLight2D

# Emotions
@onready var chat_bubble = $ChatBubble

# Movement
@export var control : bool = false;
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
@export var movement_speed = 1.00/1.5;
var moving = false

# Interactions
@onready var touch_screen_button : TouchScreenButton = $TouchScreenButton
@onready var area_2d : Area2D = $Area2D
@export var pan_speed : float = 1.00/3;
var is_being_dragged : bool  = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_savestate();
	update_sprite()

	SignalDatabase.tick_reached.connect(tick_update)
	SignalDatabase.night_started.connect(set_night)
	SignalDatabase.day_started.connect(set_day)
	SignalDatabase.outline.connect(toggle_outline)
	
	# Interactions
	area_2d.input_event.connect(handle_interaction)
	SignalDatabase.screen_touch_drag_move.connect(handle_drag)
	
	# Set outline based on config file
	toggle_outline(SettingsManager.get_value("settings","outline"))
	
	touch_screen_button.pressed.connect(interact)
	animation_player.play("idle")	

# load pet data from savestate
func load_from_savestate():
	stats = PetStats.new();
	
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

# Handle drag
func handle_drag(position : Vector2, relative : Vector2):
	if not is_being_dragged:
		return
	

	var position_delta = relative * pan_speed
	print(position_delta)
	self.position += position_delta

# Handle touch interaction
func handle_touch(event : InputEventScreenTouch):
	
	if not event.double_tap:
		return
	
	is_being_dragged = !is_being_dragged
	
	if is_being_dragged:
		SignalDatabase.notification_shown.emit("[center]Move the pet dragging")
		TouchInput.context = Game.Context.PetInteraction
		sprite.material.set_shader_parameter("width",2)
	else:
		TouchInput.context = Game.Context.Camera
		sprite.material.set_shader_parameter("width",0)
		
# Handle input for manual control
func _input(event):
	manual_movement()

# This function will be called every tick
func tick_update():
	stats.time += 1
	automatic_movement()
	normalize_stats()
	show_feelings()
	
# Manual movement
func manual_movement():
	
	if not control or moving: 
		return
	
	moving = true
	var length = 40 
	var new_position = Vector2.ZERO 

	if Input.is_action_pressed("ui_left"): 
		new_position = length * (Vector2.UP * 0.5 + Vector2.LEFT) 
	elif Input.is_action_pressed("ui_up"): 
		new_position = length * (Vector2.UP * 0.5 + Vector2.RIGHT) 
	elif Input.is_action_pressed("ui_down"): 
		new_position = length * (Vector2.DOWN * 0.5 + Vector2.LEFT)
	elif Input.is_action_pressed("ui_right"): 
		new_position = length * (Vector2.DOWN * 0.5 + Vector2.RIGHT)

	# Check future collisions
	ray.target_position = new_position
	ray.force_raycast_update()
	
	# If a collision will happen, stop
	if not ray.is_colliding() and new_position != Vector2.ZERO:
		animation_player.play("walk")
		tween = create_tween()
		tween.tween_property(self, NodeExtensor.POSITION_PROPERTIES, position + new_position, movement_speed).set_trans(Tween.TRANS_SINE)
		await tween.finished
		tween.kill()
		animation_player.play("idle")
		
	moving = false

# Normalize stat values
func normalize_stats():
	stats.hunger = clamp(stats.hunger,0,100)
	stats.affection = clamp(stats.affection,0,100)
	stats.energy =  clamp(stats.energy,0,100)
	stats.fun =  clamp(stats.fun,0,100)

# Automatic movement
func automatic_movement():
	
	if control or moving: 
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
		stats.energy -= 1
		stats.hunger += 1
		
		animation_player.play("walk")
		tween = create_tween()
		tween.tween_property(self, NodeExtensor.POSITION_PROPERTIES, position + new_position, movement_speed).set_trans(Tween.TRANS_SINE)
		await tween.finished
		tween.kill()
		animation_player.play("idle")
		
	moving = false
	

# Prepare the visuals for nighttime
func set_night() : 
	point_light.show()

# Prepare the visuals for daytime
func set_day() : 
	point_light.hide()

# Toggle the sprite outline
func toggle_outline(value:bool):
	if value:
		sprite.material.set_shader_parameter("width",1)
		return
		
	sprite.material.set_shader_parameter("width",0)

# Interact
func interact():
	pass

# Show feelings 
func show_feelings():
	if stats.hunger > 80:
		chat_bubble.visible = true
