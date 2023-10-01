extends Label

var score: int
var astronauts: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	astronauts = 0
	Messenger.SCORE_VALUECHANGED.connect(update_score)
	Messenger.WORLD_ENDGAME.connect(update_label_text)
	Messenger.WORLD_SPAWNEDASTRONAUT.connect(func(): astronauts += 1)

func update_score(_value):
	score = _value

func update_label_text():
	set_text("You successfully rescued " + 
		str(score) +
		" workers. 
		
		Unfortunately " + 
		str(astronauts - score) + 
		" of your colleagues weren't saved. Their bodies will drift endlessly through space."
	)
