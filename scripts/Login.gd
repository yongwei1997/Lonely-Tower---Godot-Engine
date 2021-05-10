extends Button

const API_KEY  = 'AIzaSyCvXivVyYJpT3A0MsR15vrAKwfL6yP5RmI'

const signUp_endpoint := 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=' + API_KEY
const signIn_endpoint := 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=' + API_KEY

var current_token := ""

onready var http : HTTPRequest = get_node("../HTTPRequest")
onready var http2 : HTTPRequest = get_node("../HTTPRequest2")
onready var email : LineEdit = get_node("../../HBoxContainer2/LineEdit")

func _on_Button_pressed():
	signUp(email.get_text(), http)
	
func _get_token_id_from_result(result: Array) -> String:
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	return result_body.idToken
	
func signUp(email: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": "123456"
	}
	http.request(signUp_endpoint, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		Session.userInfo = getUserInfo(result)

func signIn(email: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": "123456",
		"returnSecureToken": true
	}
	http.request(signIn_endpoint, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		Session.userInfo = getUserInfo(result)

func getUserInfo(result: Array) -> Dictionary:
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	return {
		"token": result_body.idToken,
		"id": result_body.localId
	}

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	
	var isExists = false
	
	if response_code != 200:
		print(response_body.result.error.message)
		
		if response_body.result.error.message == "EMAIL_EXISTS":
			isExists = true
			signIn(email.get_text(), http)
		
	else:
		print("success")
		
		if isExists == false:
			Session.profile.name = {"stringValue": email.get_text().rsplit("@", true)[0]}
			Session.profile.highest = {"integerValue": 0}
			print('asdf')
		Session.isLogin = true
		get_tree().get_root().get_child(3).queue_free()
