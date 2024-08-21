extends Node
@onready var pet: Pet = $Pet

enum COLORS_ENUM{ red,yellow,green,blue}
const PLAYERS=4
const CARDS_PER_HAND=5
@onready var control: Control = $Control
@onready var button: Button = $Control/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hands=generate_hands()
	var hand=hands[0]
	print(hand.cards)
	add_child(hand)
	hand.show_cards()
	button.pressed.connect(move.bind(hand))
	#var card=Card.new("BLUE",5)
	#add_child(card)
	#card.show_card_sprite()

func move(hand:Hand):
	hand.cards[4].move(10,4)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Generates 4 hands of cards
func generate_hands():
	var hands:Array=[]
	var deck=generate_deck()
	for player in PLAYERS:
		var cards:Array=[]
		for c in CARDS_PER_HAND:
			var random=randi()%deck.size()
			var card=deck.pop_at(random)
			cards.append(card)
		hands.append(Hand.new(cards))
		
	return hands
	

## Generates deck
func generate_deck()->Array:
	var output:Array=[]
	for color in COLORS_ENUM.keys():
		for num in range(10):
			output.append(Card.new(color,num))
	
	return output
	
class Hand:
	extends Node2D
	var cards:Array;
	
	func move(x:int,y:int):
		self.position=Vector2(x*40+40,y*20+20)
	
	func _init(cards:Array) -> void:
		self.cards=cards
		move(0,0)
		var x=0
		var y=0
		for card in cards:
			self.add_child(card)
			
			card.move(0,0)
			x+=1
			
	func show_cards():
		for card in cards:
			card.show_card_sprite()
			
class Player:
	var id:int;
	var name:String
	var hand:Hand;
	
	func _init(id:int,name:String, cards:Array) -> void:
		self.id=id
		self.name=name
		self.hand=Hand.new(cards)
