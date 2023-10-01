extends PanelContainer

@export var play_button: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.StartGame.connect(show_panel)

func show_panel():
	visible = true
