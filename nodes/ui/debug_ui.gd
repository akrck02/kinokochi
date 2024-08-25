extends Control


@onready var coordinates_label : Label = $CoordinatesLabel
@onready var position_label : Label = $LocalPositionLabel
@onready var global_position_label : Label = $GlobalPositionLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#SignalDatabase.mouse_motion_updated.connect(update_coordinates)

func _physics_process(_delta: float) -> void:
	update_coordinates(get_global_mouse_position())

# Update coordinates on label
func update_coordinates(new_global_position : Vector2):
		
	new_global_position = Positions.convert_ui_position_to_scene_global_position(get_viewport(), new_global_position)
		
	var new_local_position : Vector2i =  SceneManager.current_tilemap.to_local(new_global_position)
	var coordinates : Vector2i = SceneManager.current_tilemap.get_coordinates_from_position(new_local_position)

	global_position_label.text 	= "Global: x: {x} , y: {y}".format({"x" : "%d" % new_global_position.x, "y": "%d" % new_global_position.y})
	position_label.text 		= "Local: x: {x} , y: {y}".format({"x" : "%d" % new_local_position.x, "y": "%d" % new_local_position.y})
	coordinates_label.text 		= "Coord: x: {x} , y: {y}".format({"x" : "%d" % coordinates.x, "y": "%d" % coordinates.y})
