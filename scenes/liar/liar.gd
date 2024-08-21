extends Node
@onready var pet: Pet = $Pet

const PLAYERS=4
const CARDS_PER_HAND=5
@onready var control: Control = $Control
@onready var spin_box_y: SpinBox = $Control/HBoxContainer/SpinBoxY
@onready var spin_box_x: SpinBox = $Control/HBoxContainer/SpinBoxX
@onready var button: Button = $Control/HBoxContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var deck=Deck.new()
	print(deck.size())
	var hand=Hand.new(deck)
	print(deck.size())
	
	
	#var hands=generate_hands()
	#var hand=hands[0]
	#print(hand.cards)
	#hand.show_cards()
	#add_child(hand)
	#button.pressed.connect(move.bind(hand))
	
	# Create players with their hands
	
func move(object:IsometricObject):
	object.move(spin_box_x.value,spin_box_y.value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Generates 4 hands of cards
func generate_hands():
	var hands:Array=[]
	var deck=Deck.new()
	for player in PLAYERS:
		var cards:Array=[]
		for c in CARDS_PER_HAND:
			cards.append(deck.get_random_card())
		hands.append(Hand.new(cards))
		
	return hands
	
class Hand:
	extends IsometricObject
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
			
	func show_cards():
		for card in cards:
			card.show_card_sprite()
			
class Player:
	var id:int;
	var name:String;
	var hand:Hand;
	
	func _init(id:int,name:String, cards:Array) -> void:
		self.id=id
		self.name=name
		self.hand=Hand.new(cards)
