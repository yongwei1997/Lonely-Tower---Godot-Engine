extends Node2D


signal state_changed(new_state)

onready var player_detection_zone = $PlayerDetection

enum State{
	PATROL,
	ENGAGE
}

var current_state: int = State.PATROL setget set_state
var actor = null
var player: Player = null
var weapon: Weapon = null
var origin: Vector2 = global_position

func _process(delta):

	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				var angle_to_player = actor.global_position.direction_to(player.global_position).angle()
				#enemy rotation and attack
				actor.rotation = lerp(actor.rotation, angle_to_player, 0.1)
				if abs(actor.rotation - angle_to_player) < 0.1:
					weapon.shoot()
			else:
				print("No player/weapon")
		_:
			print("Error")

func initialize(actor,  weapon: Weapon):
	
	self.actor = actor
	self.weapon = weapon

func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body
	


func _on_PlayerDetection_body_exited(body):
	if player and body == player:
		set_state(State.PATROL)
		player = null
