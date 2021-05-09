extends Node

signal bullet_fired(bullet, position, direction)

onready var enemy = preload("res://actors/Enemy.tscn")

var points 

func _ready():
	print("HAHA")
	var mob_instance = enemy.instance()
	mob_instance.connect("goblin_defeated", self, "goblin_defeated")
	
func goblin_defeated():
	points += 10
	$UI/Points.text = str(points)
	print(points)
	
