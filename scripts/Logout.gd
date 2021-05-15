extends Control

onready var displayBox = get_node("Panel/Control/CenterContainer/HBoxContainer/TextureRect/VBoxContainer/HBoxContainer2")
onready var button = get_node("Panel/Control/CenterContainer/HBoxContainer/TextureRect/VBoxContainer/CenterContainer/Button")
func _ready():
	if Session.isLogin == true:
		displayBox.get_child(0).text = "Login as " + str(Session.profile.name.stringValue)
		displayBox.get_parent().get_child(0).hide()
		displayBox.get_child(1).hide()
		
		button.text = "Logout"
		
		
		
