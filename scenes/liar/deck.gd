extends Node
class_name Deck

const PLAYERS=4
const CARDS_PER_HAND=5
var cards:Array;
enum COLORS_ENUM{ red,yellow,green,blue}

func _init() -> void:
	self.cards=[]
	for color in COLORS_ENUM.keys():
		for num in range(10):
			cards.append(Card.new(color,num))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_random_card()->Card:
	var random=randi()%cards.size()
	return cards.pop_at(random)
	
func generate_hands():
	var hands:Array=[]
	var deck=Deck.new()
	for player in PLAYERS:
		var cards:Array=[]
		for c in CARDS_PER_HAND:
			cards.append(deck.get_random_card())
		hands.append(Hand.new(cards))
		
	return hands
