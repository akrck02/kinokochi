class_name Pet
extends CharacterBody2D

@export var pet_name : String = "tas"
@export var stats : PetStats
@onready var sprite : Sprite2D = $Sprite
@onready var point_light : PointLight2D = $PointLight2D

# Emotions
@onready var chat_bubble = $Metasprites
@onready var chat_bubble_animation_player = $Metasprites/AnimationPlayer

# Movement
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
@export var movement_speed = 1.00/1.5;
var moving = false

# Interactions
@onready var touch_screen_button : TouchScreenButton = $TouchScreenButton
@onready var touch_feed_button : TouchScreenButton = $OptionDialog/TouchScreenButtonFeed
@onready var touch_play_button : TouchScreenButton = $OptionDialog/TouchScreenButtonPlay

# Iteraction dialog
@onready var pet_action_bubble = $OptionDialog

# Pet states variables
var pet_hunger = PetStats.DEFAULT_HUNGER
var pet_affection = PetStats.DEFAULT_AFFECTION

# Called when the node enters the scene tree for the first time.
func _ready():
	load_from_savestate();
	update_sprite()

	SignalDatabase.tick_reached.connect(tick_update)
	SignalDatabase.night_started.connect(set_night)
	SignalDatabase.day_started.connect(set_day)
	SignalDatabase.outline.connect(toggle_outline)
	
	touch_screen_button.pressed.connect(interact)
	animation_player.play("idle")
	chat_bubble_animation_player.play("idle")
	

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
	#pet_bubbles()
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

func toggle_outline(value:bool):
	if value:
		sprite.material.set_shader_parameter("width",1)
	else:
		sprite.material.set_shader_parameter("width",0)

func pet_bubbles():
	#TODO -> when pets status is able to be changed, use this function to display emote bubbles to display its status
	if pet_hunger < 10:
		chat_bubble.visible =! chat_bubble.visible

func interact():
	# Toggle pet movement and show dialog bubble
	# There doesnt seem to be a ternary conditional operator on GDScript, i dont like it
	if moving == true:
		moving = false
	else:
		moving = true
		
	# NPCs will show their unique dialogs once the functinality is implemented, 'tas' will show its pet_actions
	if pet_name == "tas":
		pet_action_bubble.visible =! pet_action_bubble.visible
	else:
		chat_bubble.visible =! chat_bubble.visible
	
	
	
	
