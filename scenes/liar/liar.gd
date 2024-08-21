extends Node
@onready var pet: Pet = $Pet

enum COLORS_ENUM{ red,yellow,green,blue}
const PLAYERS=4
const CARDS_PER_HAND=5
@onready var control: Control = $Control
@onready var spin_box_y: SpinBox = $Control/HBoxContainer/SpinBoxY
@onready var spin_box_x: SpinBox = $Control/HBoxContainer/SpinBoxX
@onready var button: Button = $Control/HBoxContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var hands=generate_hands()
	#var hand=hands[0]
	#print(hand.cards)
	#add_child(hand)
	#hand.show_cards()
	var card1=Card.new("red",1)
	add_child(card1)
	card1.show_card_sprite()
	button.pressed.connect(move.bind(card1))
	
func move(card:Card):
	card.move(spin_box_x.value,spin_box_y.value)
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
	extends IsometricObject
	var cards:Array;
	
	
	func _init(cards:Array) -> void:
		self.cards=cards
		var x=0
		var y=0
		for card in cards:
			self.add_child(card)
			card.move(x,0)
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
