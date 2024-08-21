extends IsometricObject
class_name Hand

## Class that represents the list of [Card] objects that a [Player] has

## List of [Card] objects
var cards:Array;

func _init(cards:Array) -> void:
	cards.pop_back()
	self.cards=cards
	var x=0
	var y=0
	for card in cards:
		self.add_child(card)
		card.move(x,0)
		x+=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Shows all [Card] objects in the [Hand] 
func show_cards():
	for card in self.cards:
		card.show_card_sprite()
