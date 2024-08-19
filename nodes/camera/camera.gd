extends Camera2D

# Camera focus 
@export var focus_node : Node2D;
var focusing : bool = false

# Zoom params
@export var default_zoom : Vector2 = Vector2(3,3);
@export var min_zoom : float = 1;
@export var max_zoom : float = 6;
var start_zoom

# Speed variables
@export var zoom_speed : float = 0.1;
@export var pan_speed : float = 0.1;
@export var rotation_speed : float = 0.1;

# Flags
@export var can_move : bool = true;
@export var can_zoom : bool = true;
@export var can_pan : bool = true;
@export var can_rotate : bool = false;

# Movement animation
@onready var zoom_tween : Tween
@onready var offset_tween : Tween
@export var movement_speed = 1.00/1.5;
var start_distance = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalDatabase.zoom_in.connect(zoom_in)
	SignalDatabase.zoom_out.connect(zoom_out)
	SignalDatabase.camera_movement_updated.connect(update_can_move)
	SignalDatabase.screen_touch_started.connect(reset_camera_move_values)
	SignalDatabase.three_finger_touch_started.connect(return_to_default_camera_position)
	SignalDatabase.screen_touch_pinch.connect(set_zoom_start)
	SignalDatabase.screen_touch_drag_move.connect(pan_camera)
	SignalDatabase.screen_touch_drag_pinch.connect(zoom_camera_from_touch)
	
	zoom = default_zoom
	if focus_node != null: 
		focusing = true

# Process operations
func _process(_delta):
	
	if not is_current_context() or not can_move:
		return;
	
	if zoom != default_zoom or offset.x < -80 or offset.x > 80 or offset.y < -80 or offset.y > 80: 
		SignalDatabase.notification_shown.emit("[center]Tap with 3 fingers to center the camera")
	else: 
		if focus_node != null:
			position = focus_node.position
		SignalDatabase.notification_hidden.emit() 

# Reset camera move values to start a new move
func reset_camera_move_values(_id : int, _position : Vector2): 
	if not is_current_context():
		return; 
		 
	start_distance = 0

# Zoom in the camera
func zoom_in(value : float):
	zoom = limit_zoom(zoom + Vector2(value,value));

# Zoom out the camera
func zoom_out(value : float):
	zoom = limit_zoom(zoom - Vector2(value,value));

# Set zoom start
func set_zoom_start():
	if not is_current_context():
		return
	
	var touch_point_positions = TouchInput.touch_points.values()
	start_distance = touch_point_positions[0].distance_to(touch_point_positions[1])
	start_zoom = zoom

# Zoom camera from touch
func zoom_camera_from_touch():
	if not is_current_context() or not can_zoom:
		return;
	
	var touch_point_positions = TouchInput.touch_points.values()
	var current_distance = touch_point_positions[0].distance_to(touch_point_positions[1])
	var zoom_factor = start_distance / current_distance
	zoom = limit_zoom(start_zoom / zoom_factor)

# Return to default camera position 
func return_to_default_camera_position():
	
	if not is_current_context():
		return
	
	offset_tween = create_tween()
	offset_tween.tween_property(self, NodeExtensor.OFFSET_PROPERTIES, Vector2.ZERO, movement_speed).set_trans(Tween.TRANS_SINE)
	await offset_tween.finished
	offset_tween.kill()
	
	zoom_tween = create_tween()
	zoom_tween.tween_property(self, NodeExtensor.ZOOM_PROPERTIES, default_zoom, movement_speed).set_trans(Tween.TRANS_SINE)
	await zoom_tween.finished
	zoom_tween.kill()
	
# Pan camera
func pan_camera(_position : Vector2, relative : Vector2):
	if not is_current_context() or not can_pan:
		return
	
	offset -= relative * pan_speed / zoom.x;

# Limit max and min zoom
func limit_zoom(new_zoom : Vector2) -> Vector2:
	if new_zoom.x <= min_zoom: new_zoom.x = min_zoom
	if new_zoom.x >= max_zoom: new_zoom.x = max_zoom
	if new_zoom.y <= min_zoom: new_zoom.y = min_zoom
	if new_zoom.y >= max_zoom: new_zoom.y = max_zoom
	return new_zoom

# Update the can move property
func update_can_move(value : bool):
	can_move = value

# Is current context
func is_current_context() -> bool:
	return TouchInput.context == Game.Context.Camera;
