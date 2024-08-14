extends Node

const tick_time : float = 2
var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = tick_time
	timer.autostart = true
	timer.timeout.connect(emitTickSignal)
	add_child(timer)


# Emit tick signal
func emitTickSignal():
	SignalDatabase.tick_reached.emit()

