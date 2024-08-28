extends CanvasLayer
class_name TurnTimer
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var turn:String="";
var turn_ended:bool=true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	SignalDatabase.tick_reached.connect(tick_update)

func tick_update():
	label.text="{0} {1}".format([turn, int(timer.time_left)])


func start(player:Player, seconds:int):
	timer.wait_time=seconds
	turn=player.player_name
	turn_ended=false
	timer.start()

func stop():
	turn_ended=true
	timer.stop()

func _on_timer_timeout():
	turn_ended = true
