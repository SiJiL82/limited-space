extends Node

var score = 0;

var scoring = [0, 1, 3, 6]

func _ready():
	score = 0
	Messenger.PLAYER_DROPOFFASTRONAUT.connect(increase_score)

func increase_score(astronauts_in_storage):
	score += scoring[astronauts_in_storage]
	Messenger.SCORE_VALUECHANGED.emit(score)