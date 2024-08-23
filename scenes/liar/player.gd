extends IsometricObject
class_name Player
## Players of the [Liar] minigame
var id: int
var player_name:String="teko"
## List of [Card]s
var _hand: Hand
@onready var pet: Pet = $Pet


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	self.move_global(x,y)
	pet.pet_name=self.player_name
	pet.control=true
	pet.update_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_player_name(name:String):
	self.player_name=name
	pet.pet_name=name
	pet.update_sprite()
	
func set_hand(hand:Hand):
	self._hand=hand
	get_parent().add_child(self._hand)
	self._hand.move_local(0,0)
	self._hand.show_cards()
