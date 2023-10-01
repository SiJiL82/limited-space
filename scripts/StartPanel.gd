extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.STARTPANEL_STARTGAME.connect(func(): visible = false)
