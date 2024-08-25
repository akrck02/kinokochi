class_name Positions

# Convert relative to global positions
static func convert_to_scene_global_position(node_reference : Node2D, relative_position : Vector2) -> Vector2:
	return node_reference.get_viewport().get_canvas_transform().affine_inverse() * relative_position

# Convert canvas positions to global positions
static func convert_ui_position_to_scene_global_position(viewport : Viewport, canvas_position : Vector2) -> Vector2:
	return viewport.get_canvas_transform().affine_inverse() * canvas_position
