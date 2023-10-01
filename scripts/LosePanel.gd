extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.PLAYER_LOSTGAME.connect(func(): visible = true)
	Messenger.LOSEPANEL_RESETGAME.connect(func(): visible = false)
