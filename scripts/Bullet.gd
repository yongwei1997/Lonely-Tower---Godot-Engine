extends Area2D
class_name Bullet

export (int) var speed = 300

onready var kill_timer = $KillTimer

var direction: = Vector2.ZERO 


func _ready():
	kill_timer.start()

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity
	
func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_KillTimer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.has_method("handle_hit") and !body.is_in_group("player"):
		body.handle_hit()
		queue_free()
