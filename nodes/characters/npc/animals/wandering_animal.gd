extends CharacterBody2D

@onready var states : StatesNode = $StatesNode
@onready var wander_state : WanderState = $StatesNode/WanderState
@onready var follow_state : FollowState = $StatesNode/FollowState
@onready var navigation : NavigationNode = $Navigation
@onready var follow_area : Area2D = $FollowArea

func _ready():
	follow_area.body_entered.connect(start_follow)
	follow_area.body_exited.connect(stop_follow)


func _physics_process(_delta: float):
	navigation.set_tilemap(SceneManager.current_tilemap)


## Start following
func start_follow(node : Node2D):
	states.current_state = follow_state
	states.current_state.target = node
	follow_state.transitioned.emit(follow_state, follow_state.name.to_lower())


## Stop following
func stop_follow(_node : Node2D):
	states.current_state = wander_state
	
