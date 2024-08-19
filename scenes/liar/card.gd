extends Label

var number:int
var color:String

@onready var label: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text=self.text
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _init(number:int, color:String) -> void:
	self.number=number
	self.color=color
	pass
