extends MarginContainer

func _ready():
	Messenger.WORLD_ENDGAMETIMERSTARTED.connect(func(_value): visible = true)
	Messenger.WORLD_ENDGAMETIMERSTOPPED.connect(func(): visible = false)
