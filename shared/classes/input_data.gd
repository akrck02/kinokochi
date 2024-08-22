class_name InputData

var type : InputEnums.Type = InputEnums.Type.Tap
var touch_points : Dictionary = {}
var relative : Vector2 = Vector2.ZERO # This is only filled on drag move type
var index : int = -1;

# Create an InputData from the given parameters
static func from(new_index : int, new_type : InputEnums.Type, new_touch_points : Dictionary) -> InputData:
	var data = new()
	data.index = new_index
	data.type = new_type
	data.touch_points = new_touch_points
	return data

# Get the relative position of the current event
func get_current_position() -> Vector2:
	return get_position(self.index)

# Get the relative position of any other event occurred at the same time
func get_position(id : int) -> Vector2:
	return touch_points[id]

# Get the global position of the current event
func get_current_global_position(node_reference : Node2D) -> Vector2:
	return get_global_position(node_reference, self.index)

# Get the global position of any other event occurred at the same time
func get_global_position(node_reference : Node2D, id : int) -> Vector2:
	return Positions.convert_to_global_position(node_reference, touch_points[id])

# Calculate distance between the given events
func calculate_distance_between(origin_id : int, final_id : int) -> float:
	var touch_point_positions = TouchInput.touch_points.values()
	return touch_point_positions[origin_id].distance_to(touch_point_positions[final_id])
