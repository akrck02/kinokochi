extends Node2D

var context : Game.Context = Game.Context.Camera
var touch_points : Dictionary = {}

# Input handle
func _input(event):
	if event is InputEventScreenTouch: handle_touch(event);
	if event is InputEventScreenDrag:  handle_drag(event);
	# if event is InputEventMouseMotion: print(event.global_position)
		
# Handle the touch events
func handle_touch(event : InputEventScreenTouch):
	
	# Touch released
	if not event.pressed: 
		touch_points.erase(event.index)
		SignalDatabase.screen_touch_released.emit(event.index, event.position)
		return;

	# Touch
	touch_points[event.index] = event.position
	
	print("Detected touch points: ")
	print(touch_points)
	print()
	
	if touch_points.size() == 1 and event.double_tap: SignalDatabase.screen_touch_double_tap.emit(event.index, event.position, )
	elif touch_points.size() == 2: SignalDatabase.screen_touch_pinch.emit()
	elif touch_points.size() == 3: SignalDatabase.three_finger_touch_started.emit()
	elif touch_points.size() < 2: SignalDatabase.screen_touch_started.emit(event.index, event.position)
	

# Handle drag events 
func handle_drag(event : InputEventScreenDrag):
	
	touch_points[event.index] = event.position
	var global_canvas_pos = get_viewport().get_canvas_transform().affine_inverse() * event.position
	match TouchInput.touch_points.size():
		1: SignalDatabase.screen_touch_drag_move.emit(event.position, event.relative, global_canvas_pos)
		2: SignalDatabase.screen_touch_drag_pinch.emit()
