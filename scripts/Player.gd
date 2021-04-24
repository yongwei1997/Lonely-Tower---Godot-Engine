extends KinematicBody2D

class_name Player

export (int) var speed = 100
export (int) var receive_damage = 10

onready var weapon = $Weapon
onready var health_stat = $Health



func _physics_process(delta: float) -> void:
	#move()
	look_at(get_global_mouse_position())
	
func move():
	var movement_direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		movement_direction.y = -1
		
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
		
	if Input.is_action_pressed("right"):
		movement_direction.x = 1
		
	if Input.is_action_pressed("left"):
		movement_direction.x = -1

	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		weapon.shoot()
		
func handle_hit():
	health_stat.health -= receive_damage
	if health_stat.health == 0:
		queue_free()
	print("HIT E!!!", health_stat.health)
	
