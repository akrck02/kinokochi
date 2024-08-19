extends Node
@onready var pet: Pet = $Pet

enum COLORS_ENUM{ RED,YELLOW,GREEN,BLUE}
const PLAYERS=4
const CARDS_PER_HAND=5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var decks=generate_hands()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Generates 4 hands of cards
func generate_hands():
	var decks:Array[Array]=[]
	var cards=generate_deck()
	for player in PLAYERS:
		var player_deck:Array=[]
		print("Player ",1," Cards")
		for c in CARDS_PER_HAND:
			var random=randi()%cards.size()
			var card=cards.pop_at(random)
			print(card)
			player_deck.append(card)
		decks.append(player_deck)
		
	return decks
	

## Generates deck
func generate_deck()->Array:
	var cards:Array=[]
	for color in COLORS_ENUM.keys():
		for num in range(10):
			cards.append(Card.new(color,num))
	
	return cards
	
class Card:
	
	var number:int;
	var color:Color;
	var color_name:String;
	
	func _init(color:String,number:int) -> void:
		self.number=number
		match (color):
			"RED":
				self.color=Color(250,59,47)
				self.color_name="RED"
			"YELLOW":
				self.color=Color(238,250,47)
				self.color_name="YELLOW"
			"GREEN":
				self.color=Color(45,250,62)
				self.color_name="GREEN"
			"BLUE":
				self.color=Color(45,179,250)
				self.color_name="BLUE"
				
				
	
	func _to_string() -> String:
		return "{0} of {1}".format([number,color_name])
		
		
		
