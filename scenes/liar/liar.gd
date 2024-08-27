extends Node
@onready var pet: Pet = $Pet

const PLAYERS = 4
const CARDS_PER_HAND = 5
const TURN_TIME = 120

@onready var control: Control = $Control
@onready var spin_box_y: SpinBox = $Control/HBoxContainer/SpinBoxY
@onready var spin_box_x: SpinBox = $Control/HBoxContainer/SpinBoxX
@onready var button: Button = $Control/HBoxContainer/Button
@onready var player_0: Player = $Player0
@onready var player_1: Player = $Player1
@onready var player_2: Player = $Player2
@onready var player_3: Player = $Player3
@onready var button_2: Button = $Control/HBoxContainer/Button2
@onready var play_button: Button = $Control2/HBoxContainer/PlayButton
@onready var liar_button: Button = $Control2/HBoxContainer/LiarButton
@onready var spin_box: SpinBox = $Control2/HBoxContainer/SpinBox
@onready var stack: Stack = $Stack
var turn: int = 0
var game_finished: bool = false
var timer_turn = Timer.new()
var timer_turn_ended: int = true
var players: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players = [player_0, player_1, player_2, player_3]

	# Create hands
	var hands = stack.generate_hands()
	var hands_up = hands[0]
	var hands_down = hands[1]
	var hands_left = hands[2]
	var hands_right = hands[3]
	var x = 0
	var y = 3

	player_0.id = 0
	player_0.facing = Constants.FACING.DOWN
	player_0.set_hand(hands_down)
	player_0.set_reveal_cards(true)
	player_0.set_player_name("tas")
	player_0._hand.move_local(-2, 3)

	player_1.id = 1
	player_1.facing = Constants.FACING.RIGHT
	player_1.set_hand(hands_right)
	player_1.set_player_name("foxy")
	player_1._hand.move_local(3, -2)

	player_2.id = 2
	player_2.facing = Constants.FACING.UP
	player_2.set_hand(hands_up)
	player_2.set_player_name("teko")
	player_2._hand.move_local(-2, -3)

	player_3.id = 3
	player_3.facing = Constants.FACING.LEFT
	player_3.set_hand(hands_left)
	player_3.set_player_name("soriel")
	player_3._hand.move_local(-3, -2)

	button.pressed.connect(move.bind(player_1._hand))
	button_2.pressed.connect(add_card)

	play_button.disabled = true
	liar_button.disabled = true

	SignalDatabase.tick_reached.connect(tick_update)
	play_button.pressed.connect(on_play_button)
	liar_button.pressed.connect(on_liar_button)

	timer_turn.wait_time = TURN_TIME
	timer_turn.timeout.connect(_on_timer_timeout)
	add_child(timer_turn)


func add_card():
	var card_scene = preload("res://scenes/liar/card.tscn")
	var player = player_2
	var card = card_scene.instantiate()

	card.number = 3
	card.color = "red"
	card.set_facing(Constants.FACING.UP)
	player.add_card(card)


func on_play_button():
	var selected_cards = player_0.get_selected_cards()
	player_0.remove_cards(selected_cards)
	stack.add_cards(selected_cards)
	player_0.latest_statement = spin_box.value
	print(player_0.latest_statement)
	timer_turn.stop()
	timer_turn_ended = true


func on_liar_button():
	pass


func move(object: IsometricObject):
	object.move_global(spin_box_x.value, spin_box_y.value)


func tick_update() -> void:
	if timer_turn_ended:
		print("Turno de {0}".format([players[turn]]))
		var previous_player_index = (turn - 1) % 4
		var previous_player:Player = players[previous_player_index]
		var actual_player:Player = players[turn]
		if actual_player.id == 0:
			player_0._hand.set_selectable(true)
			play_button.disabled = false
			liar_button.disabled = false
			self.timer_turn_ended = false
			self.timer_turn.start()
		else:
			player_0._hand.set_selectable(false)
			# Unselect selected cards
			player_0._hand.unselect()

			play_button.disabled = true
			liar_button.disabled = true
			

			# Liar or play
			var random = randi() % 10 + 1
			random = 4

			if random < 3:  # Liar
				print("Player ",actual_player, " chose Liar")
				var latest_statement = previous_player.latest_statement

				if stack.latest_statement_true(latest_statement):
					print("Era verdad")
					actual_player.add_cards(stack.pop_latest_added_cards())

				else:
					print("Era mentira")
					previous_player.add_cards(stack.pop_latest_added_cards())

			else:  # Play
				print("Player ",actual_player, " chose Play")
				
				var lie = randi() % 10 + 1
				lie=0
				
				if lie<3:
					print("Player ",actual_player, " chose Lie")
					
					var test=actual_player.lie()
					stack.add_cards(test)
					
				else:
					print("Player ",actual_player, " chose Truth")
					
				timer_turn.stop()
				timer_turn_ended = true
				pass


			self.timer_turn.start(3)
			self.timer_turn_ended = false
		print("----\n")
		# Set turn between 0 and 3
		turn = (turn + 1) % players.size()


func _on_timer_timeout():
	self.timer_turn_ended = true
