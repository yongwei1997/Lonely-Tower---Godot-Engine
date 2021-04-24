extends Button

var button setget setButton
var scene = 'dfdf'

func setButton(value):
	scene = value

func _on_Button_pressed():
	print(scene)
