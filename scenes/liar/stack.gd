extends IsometricObject
class_name Stack

@onready var sprite_2d: Sprite2D = $Sprite2D

var cards: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_card(card:Card):
	cards.append(card)
	if cards.size()>1:
		update_sprite()
		
func add_cards(cards:Array):
	for card in cards:
		add_card(card)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_sprite():
	if not sprite_2d:
		return
	
	sprite_2d.frame=0
	sprite_2d.hframes=1
	sprite_2d.vframes=2
	sprite_2d.texture = load("res://resources/sprites/cards/white.png")
	
