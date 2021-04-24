extends Button

var button setget setButton
var scene
var clickSound = preload("res://audio/metalClick.ogg")
var sound = AudioStreamPlayer.new()

func _ready():
	clickSound.loop = false
	sound.set_stream(clickSound)
	self.add_child(sound)

func setButton(value):
	scene = value

func _on_Button_pressed():
	sound.play()
	yield(sound, "finished")
	get_tree().change_scene(scene)
	
