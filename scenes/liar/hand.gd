extends IsometricObject
class_name Hand

## Class that represents the list of [Card] objects that a [Player] has
@onready var hand: Node2D = $"."

## List of [Card] objects
var cards: Array
var cards_array: Array[Array]


func _init() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	# Initialize 5x3 array
	for i in range(3):
		var row = []
		for j in range(5):
			row.append(null)
		cards_array.append(row)


func arrange_cards():
	var x = 0
	var y = 0
	var i = 0
	var card_objects = hand.get_children()
	for card in card_objects:
		self.add_card(card)
	#for card in card_objects:
	#if i == 0:
	#i += 1
	#continue
	#match card.facing:
	#Card.FACING.UP:
	#x += 1
	#Card.FACING.DOWN:
	#x += 1
	#Card.FACING.LEFT:
	#y += 1
	#Card.FACING.RIGHT:
	#y += 1
	#card.move_local(x, y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _to_string() -> String:
	return str(cards)


## Shows all [Card] objects in the [Hand]
func show_cards():
	for card in self.cards:
		card.show_card_sprite()
		add_child(card)


func print_array():
	for i in self.cards_array:
		print(i)
	print("\n")


## Add a card to the array on the back
func add_card(card: Card):
	card.show_card_sprite()
	add_child(card)
	cards.append(card)
	for i in range(3):
		for j in range(5):
			if self.cards_array[2 - i][4 - j] == null:
				match card.facing:
					card.FACING.UP:
						card.move_local(4 - j, 2 - i)
					card.FACING.DOWN:
						card.move_local(4 - j, i - 2)
					card.FACING.LEFT:
						card.move_local(2 - i, 4 - j)
					card.FACING.RIGHT:
						card.move_local(i - 2, 4 - j)

				self.cards_array[2 - i][4 - j] = card
				return
