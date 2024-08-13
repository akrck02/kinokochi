extends Camera2D

@export var zoom_speed : float = 0.1;
@export var pan_speed : float = 0.1;
@export var rotation_speed : float = 0.1;

@export var can_zoom : bool = true;
@export var can_pan : bool = true;
@export var can_rotate : bool = false;

var touch_points : Dictionary = {}
var start_distance
var start_zoom
var start_angle
var current_angle

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.zoom_in.connect(zoom_in)
	SignalDatabase.zoom_out.connect(zoom_out)

# Input handle
func _input(event):
	
	if event is InputEventScreenTouch:
		handle_touch(event);
		
	if event is InputEventScreenDrag:
		handle_drag(event);
	
# Zoom in the camera
func zoom_in(value : float):
	zoom += Vector2(value,value)

# Zoom out the camera
func zoom_out(value : float):
	
	var new_zoom = zoom - Vector2(value,value);
	if new_zoom.x < 0:
		new_zoom = Vector2.ZERO;
		return
	
	zoom -= Vector2(value,value);

# Handle touch events 
func handle_touch(event : InputEventScreenTouch):
	
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)
		
	if touch_points.size() == 2:
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
			offset -= event.relative / zoom.x * pan_speed;

	elif touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		var current_distance = touch_point_positions[0].distance_to(touch_point_positions[1])
		var zoom_factor = start_distance / current_distance
		
		if can_zoom:
			zoom = start_zoom / zoom_factor
		
		limit_zoom(zoom)

func limit_zoom(new_zoom : Vector2):
	if new_zoom.x <= 0: zoom.x = 0.1
	if new_zoom.y <= 0: zoom.y = 0.1
	if new_zoom.x >= 10: zoom.x = 10
	if new_zoom.y >= 10: zoom.y = 10
