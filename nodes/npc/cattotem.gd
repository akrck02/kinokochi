extends CharacterBody2D

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	animationPlayer.play("idle")
