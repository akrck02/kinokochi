extends Camera2D

@export var default_zoom : Vector2 = Vector2(3,3);
@export var zoom_speed : float = 0.1;
@export var pan_speed : float = 0.1;
@export var rotation_speed : float = 0.1;

@export var can_zoom : bool = true;
@export var can_pan : bool = true;
@export var can_rotate : bool = false;

@onready var zoom_tween : Tween
@onready var offset_tween : Tween
@export var movement_speed = 1.00/1.5;

var touch_points : Dictionary = {}
var start_distance
var start_zoom
var start_angle
var current_angle

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.zoom_in.connect(zoom_in)
	SignalDatabase.zoom_out.connect(zoom_out)
	zoom = default_zoom

# Input handle
func _input(event):
	
	if event is InputEventScreenTouch:
		handle_touch(event);
		
	if event is InputEventScreenDrag:
		handle_drag(event);
	
# Zoom in the camera
func zoom_in(value : float):
	zoom = limit_zoom(zoom + Vector2(value,value));

# Zoom out the camera
func zoom_out(value : float):
	zoom = limit_zoom(zoom - Vector2(value,value));

# Handle touch events 
func handle_touch(event : InputEventScreenTouch):
	
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
		
	if touch_points.size() == 1:
		if event.double_tap:
			offset_tween = create_tween()
			offset_tween.tween_property(self, NodeExtensor.OFFSET_PROPERTIES, Vector2.ZERO, movement_speed).set_trans(Tween.TRANS_SINE)
			await offset_tween.finished
			offset_tween.kill()
			
			zoom_tween = create_tween()
			zoom_tween.tween_property(self, NodeExtensor.ZOOM_PROPERTIES, default_zoom, movement_speed).set_trans(Tween.TRANS_SINE)
			await zoom_tween.finished
			zoom_tween.kill()
		
	elif touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		start_distance = touch_point_positions[0].distance_to(touch_point_positions[1])
		start_zoom = zoom
	elif touch_points.size() < 2:
		start_distance = 0


# Handle touch events 
func handle_drag(event : InputEventScreenDrag):
	touch_points[event.index] = event.position
	
	if touch_points.size() == 1:
		if can_pan:
			offset -= event.relative * pan_speed / zoom.x;

	elif touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		var current_distance = touch_point_positions[0].distance_to(touch_point_positions[1])
			 
		if can_zoom:
			var zoom_factor = start_distance / current_distance
			zoom = limit_zoom(start_zoom / zoom_factor)
 
func limit_zoom(new_zoom : Vector2) -> Vector2:
	if new_zoom.x <= 1: new_zoom.x = 1
	if new_zoom.y <= 1: new_zoom.y = 1
	if new_zoom.x >= 6: new_zoom.x = 6
	if new_zoom.y >= 6: new_zoom.y = 6
	return new_zoom
