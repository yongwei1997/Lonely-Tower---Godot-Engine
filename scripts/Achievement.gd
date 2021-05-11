extends Control

onready var titleSize = 20
onready var labelSize = 31
onready var achievements = get_node("Control/VBoxContainer")

func _ready():
	setFontSize()
	back()

	getLeaderboard()

func setFontSize():
	var menu_lables = get_tree().get_nodes_in_group('menu_label')
	
	for label in menu_lables:
		label.get('custom_fonts/font').set_size(labelSize)
		
func back():
	var back = get_tree().get_current_scene().get_node("MarginContainer2/TextureRect/Button")
	back.setButton('res://actors/Menu.tscn')

func getLeaderboard() -> void:
	var list = Session.profile.achievements.arrayValue.values()[0]
	
	for i in range(list.size()):
		
		if list[i].booleanValue ==  true:
			achievements.get_child(i).get_child(0).get_child(0).get_child(1).text = "Done"
