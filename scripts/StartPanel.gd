extends Panel

@export var play_button: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.StartGame.connect(hide_panel)

func hide_panel():
	visible = false
