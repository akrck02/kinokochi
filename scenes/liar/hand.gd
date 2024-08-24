extends IsometricObject
class_name Hand

## Class that represents the list of [Card] objects that a [Player] has
@onready var hand: Node2D = $"."

## List of [Card] objects
var cards: Array
var cards_array:Array[Array]

func _init() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	cards_array.append([null,null,null,null,null])
	cards_array.append([null,null,null,null,null])
	
func move(x:int,y:int):
	pass


func arrange_cards():
	var x = 0
	var y = 0
	var i=0
	var card_objects = hand.get_children()
	cards_array.append(card_objects)
	for card in card_objects:
		if i==0:
			i+=1
			continue
		match card.facing:
			Card.FACING.UP:
				x += 1
			Card.FACING.DOWN:
				x += 1
			Card.FACING.LEFT:
				y += 1
			Card.FACING.RIGHT:
				y += 1
		card.move_local(x, y)

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
		
