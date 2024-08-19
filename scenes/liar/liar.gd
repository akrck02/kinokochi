extends Node
@onready var pet: Pet = $Pet

enum COLORS_ENUM{ RED,YELLOW,GREEN,BLUE}
const PLAYERS=4
const CARDS_PER_HAND=5
@onready var button: Button = $Button
@onready var cards: Node = $Cards
@onready var control: Control = $Control

const card_node=preload("res://scenes/liar/card.tscn")

func spawn_card():
	var new_card:ColorRect=card_node.instantiate()
	var label:Label=new_card.get_child(0)
	label.text="0"
	#player_0_grid_container.add_child(new_card)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(spawn_card)
	var decks=generate_hands()
	#var player_0=Player.new(0,"User",decks[0],player_0_grid_container)
	#var player_1=Player.new(1,"User",decks[1],player_1_grid_container)
	#var player_2=Player.new(2,"User",decks[2],player_2_grid_container)
	#var player_3=Player.new(0,"User",decks[3],player_3_grid_container)
	#var card=Card.new("BLUE",5)
	#card.color_rect.position=Vector2(200,500)
	#add_child(card.color_rect)
	var hand=Hand.new(decks[0])
	add_child(hand)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## Generates 4 hands of cards
func generate_hands():
	var decks:Array[Array]=[]
	var cards=generate_deck()
	for player in PLAYERS:
		var player_deck:Array=[]
		print("Player ",1," Cards")
		for c in CARDS_PER_HAND:
			var random=randi()%cards.size()
			var card=cards.pop_at(random)
			print(card)
			player_deck.append(card)
		decks.append(player_deck)
		
	return decks
	

## Generates deck
func generate_deck()->Array:
	var output:Array=[]
	for color in COLORS_ENUM.keys():
		for num in range(10):
			output.append(Card.new(color,num))
	
	return output
	
class Card:
	extends ColorRect
	
	var number:int;
	var color_name:String;
	var label:Label;
	
	func _init(color_name:String,number:int) -> void:
		
		self.label=Label.new()
		self.label.text=str(number)
		label.size=Vector2(40,60)
		label.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
		label.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size",40)
		self.add_child(label)
		
		
		match (color_name):
			"RED":
				self.color=Color(250/255.0, 59/255.0, 47/255.0, 1)
				self.color_name="RED"
			"YELLOW":
				self.color=Color(238/255.0, 250/255.0, 47/255.0, 1)
				self.color_name="YELLOW"
			"GREEN":
				self.color=Color(45/255.0, 250/255.0, 62/255.0, 1)
				self.color_name="GREEN"
			"BLUE":
				self.color=Color(45/255.0, 179/255.0, 250/255.0, 1)
				self.color_name="BLUE"
				
				
	func _to_string() -> String:
		return "{0} of {1}".format([number,color_name])
		
	func _ready() -> void:
		self.size=Vector2(40,60)
		
		
class Hand:
	extends Control
	var cards:Array;
	
	func _init(cards:Array) -> void:
		self.cards=cards
		self.position=Vector2(0,0)
		var x=0
		var y=0
		for card in cards:
			self.add_child(card)
			card.set_position(Vector2(x,y))
			x+=50
			
class Player:
	var id:int;
	var name:String
	var hand:Hand;
	
	func _init(id:int,name:String, cards:Array, grid_container:GridContainer) -> void:
		self.id=id
		self.name=name
		self.hand=Hand.new(cards)
