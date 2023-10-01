extends Node

var score = 0;

func _ready():
	score = 0
	Messenger.PLAYER_DROPOFFASTRONAUT.connect(increase_score)
	Messenger.WORLD_INITGAME.connect(func(_value): score = 0)

func increase_score(_value):	
	score += _value
	Messenger.SCORE_VALUECHANGED.emit(score)
