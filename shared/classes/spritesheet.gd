class_name Spritesheet

var path : String = "res://icon.svg"
var size : Vector2 = Vector2.ONE

# Fill SpriteSheet form params
static func from(path : String, width : int, height : int) -> Spritesheet:
	var sprite_sheet = new()
	sprite_sheet.path = path
	sprite_sheet.size.x = width
	sprite_sheet.size.y = height
	return sprite_sheet
