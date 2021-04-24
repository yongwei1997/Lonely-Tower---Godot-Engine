#score update
extends CanvasLayer
class_name Score

onready var scoreText = $Label

var score = 0 setget set_score

func set_score(new_score: int):
	
	$"Score/CanvasLayer/RichTextLabel".text = str(new_score)
	

