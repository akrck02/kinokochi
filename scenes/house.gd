extends Node2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var house_touch_screen_button : TouchScreenButton = $HouseTouchScreenButton

func _ready():
	house_touch_screen_button.pressed.connect(enter_home)

func enter_home():
	animation_player.play("enter")
	await animation_player.animation_finished
	SignalDatabase.scene_change_requested.emit("home")
