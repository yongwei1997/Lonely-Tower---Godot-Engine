extends KinematicBody2D


export (int) var weapon_damage = 150

onready var health_stat = $Health
onready var ai = $AI
onready var weapon = $Weapon

signal goblin_defeated

func _ready():
	ai.initialize(self, weapon)

func handle_hit():
	health_stat.health -= weapon_damage

	
	if health_stat.health <= 0:
		emit_signal("goblin_defeated")
		Score.score = 10
		get_tree().get_root().get_child(3).get_child(3).get_child(0).get_child(0).get_child(0).text = "Score: " + str(Score.score)
		queue_free()

