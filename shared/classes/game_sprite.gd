extends Node2D
class_name GameSprite

var spritesheet : Spritesheet = Spritesheet.new()
var coordinates : Vector2 = Vector2.ZERO

# Fill game sprite from params
static func from(spritesheet: Spritesheet, x : int, y : int ) -> GameSprite : 
	var sprite = new()
	sprite.spritesheet = spritesheet
	sprite.coordinates.x = x
	sprite.coordinates.y = y 
	return sprite
