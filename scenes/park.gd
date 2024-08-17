extends Node2D

@onready var house_touch_screen_button : TouchScreenButton = $HouseTouchScreenButton

func _ready():
	house_touch_screen_button.pressed.connect(enter_home)

func enter_home():
	SignalDatabase.scene_change_requested.emit("home")
