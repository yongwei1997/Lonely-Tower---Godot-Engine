extends Node2D

export (int) var health = 300 setget set_health
 
func set_health(new_health: int):
	health = new_health
	#emit_signal
	

