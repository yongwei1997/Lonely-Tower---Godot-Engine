extends Control

onready var titleSize = 20
onready var labelSize = 31

func _ready():
	setFontSize()
	back()
	


func setFontSize():
	var menu_lables = get_tree().get_nodes_in_group('menu_label')
	
	for label in menu_lables:
		label.get('custom_fonts/font').set_size(labelSize)
		
func back():
	var back = get_tree().get_current_scene().get_node("MarginContainer2/TextureRect/Button")
	back.setButton('res://actors/Menu.tscn')
