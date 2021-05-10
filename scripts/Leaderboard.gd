extends Control

onready var titleSize = 20
onready var labelSize = 31

onready var http = get_node("HTTPRequest")
onready var lists = get_node("Control/VBoxContainer")

func _ready():
	setFontSize()
	back()

	getLeaderboard(http)

func setFontSize():
	var menu_lables = get_tree().get_nodes_in_group('menu_label')
	
	for label in menu_lables:
		label.get('custom_fonts/font').set_size(labelSize)
		
func back():
	var back = get_tree().get_current_scene().get_node("MarginContainer2/TextureRect/Button")
	back.setButton('res://actors/Menu.tscn')

func getLeaderboard(_http: HTTPRequest) -> void:
	var url := 'https://firestore.googleapis.com/v1/projects/' + Session.PROJECT_ID + '/databases/(default)/documents:runQuery'
	
	var query = {
		"structuredQuery": {
			"orderBy" : [{
				"field": {"fieldPath": "highest"},
				"direction": "DESCENDING",
			}],
			"limit": 5,
			"from": [{"collectionId": "users"}]
		}
	}
	
	
	var body := to_json(query)
	
	_http.request(url, [], false, HTTPClient.METHOD_POST, body)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	
	var result_body = JSON.parse(body.get_string_from_ascii()).result
	
	for i in range(result_body.size()):
		var item = result_body[i] as Dictionary
		
		lists.get_child(i).get_child(0).get_child(0).get_child(0).text = str(i+1) + ". " + str(item.document.fields.name.stringValue)
		lists.get_child(i).get_child(0).get_child(0).get_child(1).text = str(item.document.fields.highest.integerValue) + " pts"
		


#	print(typeof(result_body))
