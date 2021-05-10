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
	
	var popup = preload("res://actors/Login.tscn")
	
	popup = popup.instance()
	get_tree().get_root().add_child(popup)



