extends Control

onready var displayBox = get_node("Panel/Control/CenterContainer/HBoxContainer/TextureRect/VBoxContainer/HBoxContainer2")
onready var button = get_node("Panel/Control/CenterContainer/HBoxContainer/TextureRect/VBoxContainer/CenterContainer/Button")
func _ready():
	if Session.isLogin == true:
		displayBox.get_child(0).text = str(Session.profile.name.stringValue)
		displayBox.get_child(1).hide()
		
		button.text = "Logout"
		
		
		
