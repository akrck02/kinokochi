extends CharacterBody2D

@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	animationPlayer.play("idle")
