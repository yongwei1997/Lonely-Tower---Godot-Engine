extends KinematicBody2D


export (int) var weapon_damage = 30

onready var health_stat = $Health
onready var ai = $AI
onready var weapon = $Weapon
onready var score = $Score

signal goblin_defeated

func _ready():
	ai.initialize(self, weapon)
	

func handle_hit():
	health_stat.health -= weapon_damage
	print("HIT P!!!", health_stat.health)
	if health_stat.health <= 0:
		emit_signal("goblin_defeated")
		queue_free()

	

