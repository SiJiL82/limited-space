extends Label

var text_prefix: String = "Score: "

func _ready():
	Messenger.SCORE_VALUECHANGED.connect(update_label)
	update_label(0)

func update_label(score):
	set_text(text_prefix + str(score))
