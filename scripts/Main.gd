extends Node2D


onready var bullet_manager = $BulletManager
onready var player: Player = $Player

func _ready():
	GlobalSignal.connect("bullet_fired", bullet_manager, "handle_bullet_spawned") 


