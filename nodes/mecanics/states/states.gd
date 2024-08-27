extends Node2D
class_name StatesNode

@export var initial_state : State
var current_state : State
var states : Dictionary = {}

func _ready():
	SignalDatabase.tick_reached.connect(_tick_process)
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func transition(state : State, new_state_name : String):
	if state != current_state: 
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state


func _process(delta: float):
	if current_state:
		current_state.process(delta)

func _physics_process(delta: float):
	if current_state:
		current_state.physics_process(delta)

func _tick_process():
	if current_state:
		current_state.tick_process()
