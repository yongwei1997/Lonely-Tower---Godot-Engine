extends Control

onready var titleSize = 20
onready var labelSize = 31

var scenes = ['res://actors/Main.tscn', 'res://actors/Achievement.tscn', 'res://actors/Leaderboard.tscn', 'res://actors/Lose.tscn']

var bgm = preload("res://audio/menu_bgm.mp3")
var sound = AudioStreamPlayer.new()

func _ready():
	bgm.loop = true
	sound.set_stream(bgm)
	self.add_child(sound)
	sound.play()
	
	setFontSize()
	onClickHandler()


func onClickHandler():
	var menu_labels = get_tree().get_nodes_in_group('menu_label')
	
	for index in range(menu_labels.size()):
		menu_labels[index].get_parent().get_parent().get_child(1).setButton(scenes[index])
		

func setFontSize():
	var menu_lables = get_tree().get_nodes_in_group('menu_label')
	
	for label in menu_lables:
		label.get('custom_fonts/font').set_size(labelSize)
