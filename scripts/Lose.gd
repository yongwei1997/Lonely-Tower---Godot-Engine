extends Control

onready var results = get_node("Panel/Control/CenterContainer/HBoxContainer/TextureRect/VBoxContainer/VBoxContainer")
onready var buttons = get_node("Panel/Control/CenterContainer/HBoxContainer/TextureRect/VBoxContainer/CenterContainer").get_children()
onready var http = get_node("HTTPRequest")

var scenes = ['res://actors/Main.tscn', 'res://actors/Menu.tscn']

func _ready():
	onClickHandler()
	
	results.get_child(1).text = "Your Score: " + str(Score.score)
	
	if Session.isLogin:
		results.get_child(0).text = str(Session.profile.name.stringValue)
		
		var changes = false
		
		if Score.score > int(Session.profile.highest.integerValue):
			Session.profile.highest.integerValue = Score.score
			results.get_child(2).text = "New High Score!!!"
			changes = true
			
		var achievements = Session.profile.achievements.arrayValue.values
		
		if Score.score >= 100 and achievements[0].booleanValue == false:
			achievements[0].booleanValue = true
			changes = true

		if Score.score >= 500 and achievements[1].booleanValue == false:
			achievements[1].booleanValue = true
			changes = true

		if Score.score >= 1000 and achievements[2].booleanValue == false:
			achievements[2].booleanValue = true
			changes = true

		if achievements[3].booleanValue == false:
			achievements[3].booleanValue = true
			changes = true
			
#		if Score.score >= 1000 and achievements[4]:
#			achievements[2].booleanValue = true
		if changes == true:
			Session.updateDocument("users/" + Session.userInfo.id, Session.profile, http)
			
	
	

func onClickHandler():	
	for index in range(buttons.size()):
		buttons[index-1].setButton(scenes[index-1])


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii())
		
	if response_code != 200:
		print(response_body.result.error.message)
