extends Node

var score = 0;

func _ready():
	score = 0
	Messenger.PLAYER_DROPOFFASTRONAUT.connect(increase_score)

func increase_score(_value):	
	score += _value
	Messenger.SCORE_VALUECHANGED.emit(score)
