#score update
extends CanvasLayer

var score = 0 setget set_score, get_score

func set_score(new_score: int):
	score += new_score	
	
func get_score():
	return score
