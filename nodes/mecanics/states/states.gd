extends Node2D
class_name StatesNode

## Runtime guard
@onready var runtime_guard : RuntimeGuard = RuntimeGuard.for_node(name)

# Dependancy injection
@export var actor : CharacterBody2D
@export var initial_state : State

# State management
var current_state : State
var states : Dictionary = {}

## Logic to be executed when node is ready
func _ready():
	runtime_guard.register_parameter("actor",actor)
	if not runtime_guard.calculate_if_runtime_must_be_enabled():
		Nodes.stop_node_logic_process(self)
		return
	
	_connect_signals()
	_register_states()
	transition(initial_state)


## Connect the necessary signals 
func _connect_signals():
	SignalDatabase.tick_reached.connect(_tick_process)

## Register child states as usable states
func _register_states():
	for child in get_children():
		if child is State and (child as State).runtime_guard.is_runtime_enabled():
			states[child.name.to_lower()] = child
			child.actor = actor
			child.enter_requested.connect(transition)
			child.exit_requested.connect(handle_state_exit_request)

## Exit from the state to next if possible (initial_state will be used if no next state provided)
func handle_state_exit_request(_state : State): 
	
	# if no next state was provided, initial_state
	if initial_state:
		transition(initial_state)


## Transition between current state and the new one
func transition(new_state : State):

	if not new_state or not states.has(new_state.name.to_lower()):
		return

	if current_state:
		print("Exiting state %s" % current_state.name)
		current_state.exit()
	
	print("Entering state %s" % new_state.name)
	
	new_state.enter()
	current_state = new_state


## Process logic
func _process(delta: float):
	if not current_state:
		return
	
	current_state.process(delta)


# Physics logic
func _physics_process(delta: float):
	if not current_state:
		return
	
	current_state.physics(delta)


# Tick process logic 
func _tick_process():
	if not current_state:
		return
		
	current_state.tick()
