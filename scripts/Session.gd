extends Node

var isLogin = false
var userInfo = Dictionary() setget setInfo
var profile = {
	"name" : {},
	"email": {"stringValue": {}},
	"highest": {"integerValue": 0},
	"achievements": {"arrayValue": {"values":[
		
		{"booleanValue": false},
		{"booleanValue": false},
		{"booleanValue": false},
		{"booleanValue": false},
		{"booleanValue": false}
		
	]}}

}

const API_KEY  = 'AIzaSyCvXivVyYJpT3A0MsR15vrAKwfL6yP5RmI'
const PROJECT_ID = 'lonelytower-7abdd'
const firestore_endpoint := 'https://firestore.googleapis.com/v1/projects/' + PROJECT_ID + '/databases/(default)/documents/'

onready var http = get_node("../container/HTTPRequest") 

func _ready():
	http.connect("request_completed", self, "_on_request_completed")

func setInfo(val: Dictionary):
	userInfo = val
	print(userInfo)
	if userInfo != {}:
		getDocument("users/" + userInfo.id, http)

func getDocument(path: String, _http: HTTPRequest) -> void:
	var url := firestore_endpoint + path
	_http.request(url, getRequestHeaders(), false, HTTPClient.METHOD_GET)

func _on_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary 
	
	if result_body.has("fields"):
		
		profile.name = result_body.fields.name
		profile.highest = result_body.fields.highest
		profile.email = result_body.fields.email
		profile.achievements = result_body.fields.achievements
		print(profile)
		
	else:		
		profile.name = {"stringValue": profile.email.stringValue.rsplit("@", true)[0]}
		profile.highest = {"integerValue": 0}
		saveDocument("users?documentId=" + userInfo.id, profile, http)

func getRequestHeaders() -> PoolStringArray:
	return PoolStringArray([
		"Content-Type: application/json",
		"Authorization: Bearer " + userInfo.token
	])

func saveDocument(path: String, fields: Dictionary, http: HTTPRequest) -> void:
	var document:= { "fields": fields}
	var body := to_json(document)
	print(body)
	var url := firestore_endpoint + path
	var res = http.request(url, getRequestHeaders(), true, HTTPClient.METHOD_POST, body)

func updateDocument(path: String, fields: Dictionary, http: HTTPRequest) -> void:
	var document := { "fields": fields}
	var body = to_json(document)
	var url = firestore_endpoint + path
	http.request(url, getRequestHeaders(), true, HTTPClient.METHOD_PATCH, body)
	print(body)

#func deleteDocument(path: String, http: HTTPRequest) -> void:
#	var url = firestore_endpoint + path
#	http.request(url, getRequestHeaders(), false, HTTPClient.METHOD_DELETE)
#

