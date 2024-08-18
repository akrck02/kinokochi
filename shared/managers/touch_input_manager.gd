extends Node2D
var touch_points : Dictionary = {}

# Input handle
func _input(event):
	
	if event is InputEventScreenTouch: handle_touch(event);
	if event is InputEventScreenDrag:  handle_drag(event);
		
# Handle the touch events
func handle_touch(event : InputEventScreenTouch):
	
	# Touch released
	if not event.pressed: 
		touch_points.erase(event.index)
		SignalDatabase.screen_touch_released.emit(event.index, event.position)
		return;

	touch_points[event.index] = event.position
	if touch_points.size() == 1 and event.double_tap: SignalDatabase.screen_touch_double_tap.emit(event.index, event.position)
	elif touch_points.size() == 2: SignalDatabase.screen_touch_pinch.emit()
	elif touch_points.size() < 2: SignalDatabase.screen_touch_started.emit(event.index, event.position)

# Handle drag events 
func handle_drag(event : InputEventScreenDrag):
	
	touch_points[event.index] = event.position
	match TouchInput.touch_points.size():
		1: SignalDatabase.screen_touch_drag_move.emit(event.relative)
		2: SignalDatabase.screen_touch_drag_pinch.emit()
