extends IsometricObject
class_name Hand

## Class that represents the list of [Card] objects that a [Player] has
@onready var hand: Node2D = $"."

## List of [Card] objects
var cards: Array
var cards_array: Array[Array]
var facing: Constants.FACING
var reveal: bool = false
## If user can select cards
var selectable: bool = false


func _init() -> void:
	# Initialize 5x3 array
	for i in range(3):
		var row = []
		for j in range(5):
			row.append(null)
		cards_array.append(row)
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _to_string() -> String:
	return str(cards)


## Shows all [Card] objects in the [Hand]
func show_cards():
	for card in self.cards:
		card.show_card_sprite()


func print_array():
	for i in self.cards_array:
		print(i)
	print("\n")


func set_reveal(value: bool):
	for card in cards:
		card.set_reveal(value)


func add_cards(cards: Array):
	for card in cards:
		add_card(card)


func set_user(value: int):
	for card in cards:
		card.user = value


func set_selectable(value: bool):
	self.selectable = value
	for card in cards:
		card.set_selectable(value)


## Unselect all cards in hand
func unselect():
	for card in cards:
		card.unselect()


func get_selected_cards() -> Array:
	var output = []
	for card in cards:
		if card.selected:
			output.append(card)

	return output


## Add a card to the array on the back
func add_card(card: Card):
	if card.facing != self.facing:
		card.set_facing(self.facing)
	card.show_card_sprite()
	card.visible = true
	card.set_reveal(self.reveal)
	add_child(card, true)
	cards.append(card)
	for i in range(3):
		for j in range(5):
			if self.cards_array[2 - i][4 - j] == null:
				match card.facing:
					Constants.FACING.DOWN:
						card.move_local(4 - j, 2 - i)
					Constants.FACING.UP:
						card.move_local(4 - j, i - 2)
					Constants.FACING.RIGHT:
						card.move_local(2 - i, 4 - j)
					Constants.FACING.LEFT:
						card.move_local(i - 2, 4 - j)

				self.cards_array[2 - i][4 - j] = card
				return
