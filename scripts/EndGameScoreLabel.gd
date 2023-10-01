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
	var label_text
	if astronauts - score == 0:
		label_text = "Congratulations - you successfully rescued all the workers!
		
		Now to figure out how you're all going to get off this damaged space station safely...
		"
	else:
		var count_suffix = "" if score == 1 else "s"
		label_text = "You successfully rescued " + str(score) + " worker" + count_suffix + " 
		
			Unfortunately " + str(astronauts - score) + " of your colleagues weren't saved. Their bodies will drift endlessly through space."
	
	set_text(label_text)
