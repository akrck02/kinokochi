extends CharacterBody2D

# UI 
@onready var Sprite : Sprite2D = $Sprite2D 
@onready var AngrySprite : Sprite2D = $Angry
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

# State management
@onready var isPerformingAnimation = false;

func _ready():
	AngrySprite.visible = false;
	animationPlayer.animation_finished.connect(finishPerformingAnimation)

func _process(delta):
	return;
	var state = calculate_state()
	playAnimationByState(state)

func playAnimationByState(state : States.CharacterStates):
	
	if(isPerformingAnimation):
		return
	
	isPerformingAnimation = true
	match state:
		States.CharacterStates.HAPPY: 
			animationPlayer.play("jump");
			
		States.CharacterStates.ANGRY: 
			animationPlayer.play("angry");

func calculate_state() -> States.CharacterStates:
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	# Prints a random integer between 0 and 49.
	var anim = randi() % 2
	if anim == 0:
		return States.CharacterStates.HAPPY
	
	return States.CharacterStates.ANGRY

func finishPerformingAnimation(param):
	isPerformingAnimation = false
