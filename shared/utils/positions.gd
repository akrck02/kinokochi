class_name Positions

# Convert relative to global positions
static func convert_to_global_position(node_reference : Node2D, relative_position : Vector2):
	return node_reference.get_viewport().get_canvas_transform().affine_inverse() * relative_position
