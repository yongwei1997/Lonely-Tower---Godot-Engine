extends Node2D

var points = 0

onready var bullet_manager = $BulletManager
onready var player: Player = $Player

func _ready():
	Score.score = 0
	GlobalSignal.connect("bullet_fired", bullet_manager, "handle_bullet_spawned") 
	back()

func back():
	var back = get_tree().get_current_scene().get_node("HBoxContainer/TextureRect/Button")
	back.setButton('res://actors/Menu.tscn')
