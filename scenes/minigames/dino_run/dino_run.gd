extends Node2D

# Parallax
@export var global_speed : float = 1.5;
@onready var parallax : Parallax2D = $Rotation/Parallax2D;
@onready var cloud_particles : GPUParticles2D = $CloudParticles

# Spawn parameters
@onready var spawn_area : Area2D = $SpawnArea
@onready var despawn_area : Area2D = $DespawnArea
@onready var spawn_timer : Timer = $SpawnTimer
@onready var dino_enemy_scene = preload("res://scenes/minigames/dino_run/dino_enemy.tscn");
var spawned_enemies : Array = [];

# Dino 
@onready var dino : DinoRunCharacter = $Dino

# Score
@onready var score_label : Label = $ui/Container/MarginContainer/PanelContainer/Score
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_speeds()
	
	SignalDatabase.dinorun_update_score.connect(update_score)
	despawn_area.area_entered.connect(despawn_enemy)
	
	spawn_timer.wait_time = 1
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(spawn_enemy)
	spawn_timer.start()


# Spawn an enemy
func spawn_enemy():
	
	var size = 460
	var new_position = spawn_area.position;
	new_position.x += size
	new_position.y += size * 0.5
	 
	var enemy : DinoRunEnemy = dino_enemy_scene.instantiate()
	enemy.global_speed = global_speed
	enemy.type = randi_range(1,2)
	enemy.position = new_position;
	add_child(enemy)
	
	spawned_enemies.append(enemy)
	spawn_timer.wait_time = randf_range(1,1.5) 

# Despawn an enemy
func despawn_enemy(area : Area2D):
	spawned_enemies.erase(area.get_parent())
	area.get_parent().queue_free()

# Add to score and update.
func update_score():
	score += 1
	score_label.text = "%08d" % score
	global_speed = round_to_dec(1.5 + log(score) / log(10) , 2)
	update_speeds()

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func update_speeds():
	dino.global_speed = global_speed
	var autoscroll_speed = Vector2(-160, 0) * global_speed
	autoscroll_speed.x = round_to_dec(autoscroll_speed.x,0)
	parallax.autoscroll = autoscroll_speed 
	
	cloud_particles.process_material.set("gravity", Vector3(-98 * global_speed, -49 * global_speed, 0))
	
	for enemy in spawned_enemies:
		enemy.global_speed = global_speed
