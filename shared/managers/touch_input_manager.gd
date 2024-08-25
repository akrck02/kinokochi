extends Node2D

var context : Game.Context = Game.Context.Camera
var touch_points : Dictionary = {}

# Input handle
func _input(event):
	if event is InputEventScreenTouch: handle_touch(event)
	if event is InputEventScreenDrag:  handle_drag(event)
	if event is InputEventMouseMotion: handle_mouse_motion(event)

# Handle the touch events
func handle_touch(event : InputEventScreenTouch):
	
	# Unregister touch events on releas
	if not event.pressed: 
		SignalDatabase.screen_touch_released.emit( InputData.from(event.index, InputEnums.Type.TapRelease, touch_points))
		touch_points.erase(event.index)
		return;

	# Register touch events
	touch_points[event.index] =  event.position

	# Switch between the touch types
	var data = InputData.from(event.index, InputEnums.Type.Tap, touch_points)

	if touch_points.size() == 1 and event.double_tap: 
		data.type = InputEnums.Type.DoubleTap
		SignalDatabase.screen_touch_double_tap.emit(data)
	
	elif touch_points.size() == 1: 
		SignalDatabase.screen_touch_started.emit(data)
	
	elif touch_points.size() == 2: 
		data.type = InputEnums.Type.Pinch
		SignalDatabase.screen_touch_pinch.emit(data)
	
	elif touch_points.size() == 3: 
		data.type = InputEnums.Type.ThreeFingerTap
		SignalDatabase.three_finger_touch_started.emit(data)


# Handle drag events 
func handle_drag(event : InputEventScreenDrag):
	
	touch_points[event.index] =  event.position
	var data = InputData.from(event.index, InputEnums.Type.Tap, touch_points)
	
	# Switch between drag types
	match TouchInput.touch_points.size():
		1:  
			data.type = InputEnums.Type.DragMove
			data.relative = event.relative
			SignalDatabase.screen_touch_drag_move.emit(data)
		2:  
			data.type = InputEnums.Type.DragPinch
			SignalDatabase.screen_touch_drag_pinch.emit(data)

# Handle mouse motion
func handle_mouse_motion(event : InputEventMouseMotion):
	SignalDatabase.mouse_motion_updated.emit(event.global_position)
