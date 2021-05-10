extends Button

var clickSound = preload("res://audio/metalClick.ogg")
var sound = AudioStreamPlayer.new()

func _ready():
	clickSound.loop = false
	sound.set_stream(clickSound)
	self.add_child(sound)

func _on_Button_pressed():
	sound.play()
	yield(sound, "finished")
	
	get_tree().get_root().get_child(3).queue_free()
