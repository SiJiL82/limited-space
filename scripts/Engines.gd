extends Node3D

@onready var timer = $EngineShowTimer

func _ready():
	timer.connect("timeout", func(): visible = false)
	Messenger.PLAYER_THRUSTAPPLIED.connect(show_engines)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_engines():
	visible = true
	timer.start(0.5)
