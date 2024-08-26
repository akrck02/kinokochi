extends IsometricObject
class_name Player
## Players of the [Liar] minigame
var id: int
var player_name: String = "teko"
## List of [Card]s
var _hand: Hand
@onready var pet: Pet = $Pet
var facing: Constants.FACING


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.move_global(x,y)
	pet.pet_name = self.player_name
	pet.control = true
	pet.update_sprite()

func _to_string() -> String:
	return "{0} {1}".format([id, player_name])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_selected_cards():
	var output=[]
	for card in _hand.cards:
		if card.selected:
			output.append(card)
			
	return output

## Gets a set of cards, with the same number if [param lie] is [code]false[/code]
func get_random_cards(lie:bool):
	if lie:
		
		pass
	pass

func remove_cards(cards:Array):
	for card in cards:
		remove_card(card)

func remove_card(card:Card):
	_hand.cards.remove_at(_hand.cards.find(card))
	_hand.cards_array.remove_at(_hand.cards_array.find(card))
	card.hide()
	card.move_global(0,0)
	card.unselect()
	
func add_card(card:Card):
	_hand.add_card(card)

func set_player_name(name: String):
	self.player_name = name
	pet.pet_name = name
	pet.update_sprite()

func set_reveal_cards(value:bool):
	for card in _hand.cards:
		card.set_reveal(value)
	

func set_hand(hand: Hand):
	hand.set_user(id)
	self._hand = hand
	get_parent().add_child(self._hand)
	self._hand.move_local(0, 0)
	self._hand.show_cards()
