extends KinematicBody2D


export (int) var weapon_damage = 30

onready var health_stat = $Health
onready var ai = $AI
onready var weapon = $Weapon
onready var score = $Score

func _ready():
	ai.initialize(self, weapon)
	

func handle_hit():
	health_stat.health -= weapon_damage
	print("HIT P!!!", health_stat.health)
	if health_stat.health <= 0:
		queue_free()
		if queue_free() == true:
					#score update
			score.score += 10
			print("Score: ", score)
	

