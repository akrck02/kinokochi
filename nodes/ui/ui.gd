extends CanvasLayer

@onready var timeLabel : RichTextLabel = $Banner/Time 
@onready var filter : ColorRect = $Filter
@onready var info : RichTextLabel = $InfoBanner/Info
@onready var info_animation_player : AnimationPlayer = $InfoBanner/AnimationPlayer
@onready var info_timer : Timer = $InfoBanner/Timer

var notification_showing = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.tick_reached.connect(update_tick);
	SignalDatabase.night_started.connect(set_night_color_palette)
	SignalDatabase.day_started.connect(set_day_color_palette)
	SignalDatabase.notification_shown.connect(show_notification)
	SignalDatabase.notification_hidden.connect(hide_notification)
	update_time()

func _input(_event):
	if Input.is_action_just_released('ui_zoom_in'):
		_on_zoom_in_button_pressed()
	if Input.is_action_just_released('ui_zoom_out'):
		_on_zoom_out_button_pressed()
	
func _on_zoom_in_button_pressed():
	SignalDatabase.zoom_in.emit(.5)

func _on_zoom_out_button_pressed():
	SignalDatabase.zoom_out.emit(.5)

func update_tick():
	update_time()
	
func update_time():
	var time = TimeManager.get_real_time();
	timeLabel.text = "[right] {hh}:{mm}".format({"hh": "%02d" % time.hour, "mm": "%02d" % time.minute })
	TimeManager.emit_daytime()
	
# Set night color palette
func set_night_color_palette():
	filter.material = load("res://materials/filter_shader_material_night.tres")

# Set day color palette
func set_day_color_palette():
	filter.material = load("res://materials/filter_shader_material_day.tres")

# Show notification
func show_notification(message : String):
	
	if notification_showing: 
		return
	
	info.text = message
	info_animation_player.play("notification_in")
	notification_showing = true

# Hide notification
func hide_notification():
	
	if not notification_showing:
		return
	
	info_animation_player.play("notification_out")
	info.text = ""
	notification_showing = false

