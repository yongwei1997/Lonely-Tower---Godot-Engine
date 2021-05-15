extends Node2D

var timer = 0
export var spawnTime = 2 

var follower = preload("res://actors/Path2D_Enemy1.tscn")
var rng = RandomNumberGenerator.new()

func _process(delta):
		
	timer += delta
	if timer > spawnTime:
		
		rng.randomize()
		var rand = rng.randi_range(0, 3)
		
		timer = 0

		var newFollower = follower.instance()
		
		if get_child(rand).is_in_group('right'):
			newFollower.get_child(0).get_child(0).set_flip_h(true)
		
		get_child(rand).add_child(newFollower)

		
		
