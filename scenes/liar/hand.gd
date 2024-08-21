extends IsometricObject
class_name Hand

## Class that represents the list of [Card] objects that a [Player] has
@onready var hand: Node2D = $"."

## List of [Card] objects
var cards:Array;

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(1)
	var x=0;
	var y=0;
	var card_objects=hand.get_children()
	for card in card_objects:
		card.move(x,y)
		x+=1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Shows all [Card] objects in the [Hand] 
func show_cards():
	for card in self.cards:
		card.show_card_sprite()
		add_child(card)
