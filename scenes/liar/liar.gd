extends Node
@onready var pet: Pet = $Pet

const PLAYERS = 4
const CARDS_PER_HAND = 5
@onready var control: Control = $Control
@onready var spin_box_y: SpinBox = $Control/HBoxContainer/SpinBoxY
@onready var spin_box_x: SpinBox = $Control/HBoxContainer/SpinBoxX
@onready var button: Button = $Control/HBoxContainer/Button
var deck: Deck
@onready var player_0: Player = $Player0
@onready var player_1: Player = $Player1
@onready var player_2: Player = $Player2
@onready var player_3: Player = $Player3
@onready var button_2: Button = $Control/HBoxContainer/Button2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Generate Deck
	deck = Deck.new()
	# Create hands
	var hands = deck.generate_hands()
	var x = 0
	var y = 3
	#for hand in hands:
	#hand.move(x,y)
	#hand.show_cards()
	#add_child(hand)
	#x+=6

	player_0.id = 0
	player_0.set_hand(hands[0])
	player_0._hand.arrange_cards()
	player_0.set_player_name("tas")
	player_0._hand.move_local(-2, 5)

	player_1.id = 1
	player_1.set_hand(hands[1])
	player_1._hand.arrange_cards()
	player_1.set_player_name("foxy")
	player_1._hand.move_local(-2, -5)
	print(player_1._hand.print_array())

	player_2.id = 2
	player_2.set_hand(hands[2])
	player_2._hand.arrange_cards()
	player_2.set_player_name("teko")
	player_2._hand.move_local(5, -2)

	player_3.id = 3
	player_3.set_hand(hands[3])
	player_3._hand.arrange_cards()
	player_3.set_player_name("soriel")
	player_3._hand.move_local(-5, -2)

	button.pressed.connect(move.bind(player_1._hand))
	button_2.pressed.connect(add_card)

	# Create players

	# Add card
	#var card=Card.new();
	#card.color="red"
	#card.number=6
	#card.show_card_sprite()
	#add_child(card)


func add_card():
	var card = Card.new()
	card.facing = card.FACING.RIGHT
	card.number = 3
	card.color = "red"
	player_3._hand.add_card(card)
	player_3._hand.print_array()


func move(object: IsometricObject):
	object.move_global(spin_box_x.value, spin_box_y.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
