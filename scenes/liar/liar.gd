extends Node
@onready var pet: Pet = $Pet

const PLAYERS=4
const CARDS_PER_HAND=5
@onready var control: Control = $Control
@onready var spin_box_y: SpinBox = $Control/HBoxContainer/SpinBoxY
@onready var spin_box_x: SpinBox = $Control/HBoxContainer/SpinBoxX
@onready var button: Button = $Control/HBoxContainer/Button
var deck:Deck;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck=Deck.new()
	var hands=deck.generate_hands()
	add_child(hands[0])
	hands[0].show_cards()
	
	
	#var hands=generate_hands()
	#var hand=hands[0]
	#print(hand.cards)
	#hand.show_cards()
	#add_child(hand)
	button.pressed.connect(move.bind(hands[0]))
	
	# Create players with their hands
	
func move(object:IsometricObject):
	object.move(spin_box_x.value,spin_box_y.value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
