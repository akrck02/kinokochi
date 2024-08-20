class_name Card
extends Sprite2D
var number:int;
var color_name:String;

func _init(color_name:String,number:int) -> void:
	
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
