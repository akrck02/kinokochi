extends IsometricObject
class_name Player
## Players of the [Liar] minigame
var id: int
var player_name: String = "teko"
## List of [Card]s
var _hand: Hand
@onready var pet: Pet = $Pet
var facing: Constants.FACING
var latest_statement: int = 0


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


func add_cards(cards: Array):
	for card in cards:
		
		add_card(card)

## Gets a random number of random cards
## Returns [Array] of [Card]
func lie()->Array:
	var output=[]
	var max=3
	
	if _hand.cards.size()<3:
		max=_hand.cards.size()
		
	# Number of cards to play
	var num_cards=randi_range(1,max)
	
	# TODO: Remove numbers that are discarded from game
	latest_statement=randi_range(0,9)
	
	for i in num_cards:
		var random_card
		output.append(pop_random_card())
		
	return output
	
## Gets a random number from Player's cards and returns all the cards with the same number
## Returns [Array] of [Card]
func truth()->Array:
	var output=[]
	var random_card=pop_random_card()
	latest_statement=random_card.number
	output.append(random_card)
	for card in _hand.cards:
		if card.number==random_card.number:
			output.append(card)
			remove_card(card)
	
	return output


## Gets Cards with selected [code]true[/code]
func get_selected_cards()->Array:
	var output = []
	for card in _hand.cards:
		if card.selected:
			output.append(card)

	return output

## Gets a random card
func pop_random_card()->Card:
	var random = randi() % _hand.cards.size()
	var random_card=_hand.cards[random]
	
	remove_card(random_card)
	
	return random_card


## Removes given [Card]s from [Hand]
func remove_cards(cards: Array)->void:
	
	for card in cards:
		remove_card(card)


## Removes given [Card] from [Hand]
func remove_card(card: Card)->void:
	_hand.cards.remove_at(_hand.cards.find(card))
	_hand.cards_array.remove_at(_hand.cards_array.find(card))
	#card.hide()
	_hand.remove_child(card)
	card.move_global(0, 0)
	card.unselect()


func add_card(card: Card):
	_hand.add_card(card)


func set_player_name(name: String):
	self.player_name = name
	pet.pet_name = name
	pet.update_sprite()


func set_reveal_cards(value: bool):
	for card in _hand.cards:
		card.set_reveal(value)


func set_hand(hand: Hand):
	hand.set_user(id)
	self._hand = hand
	get_parent().add_child(self._hand)
	self._hand.move_local(0, 0)
	self._hand.show_cards()
