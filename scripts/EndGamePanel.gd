extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.WORLD_ENDGAME.connect(func(): visible = true)
	Messenger.WORLD_INITGAME.connect(func(_value): visible = false)
