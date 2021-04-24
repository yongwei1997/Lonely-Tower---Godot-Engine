extends Path2D

var timer = 0
export var spawnTime = 5

var follower = preload("res://actors/Path2D_Enemy1.tscn")
var hasSpawn = false

func _process(delta):
	timer = timer + delta
	if (timer > spawnTime):
		var newFollower = follower.instance()
		add_child(newFollower)
		timer = 0
		
