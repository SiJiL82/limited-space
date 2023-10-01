extends Node3D

@onready var timer = $EngineShowTimer

func _ready():
	timer.connect("timeout", func(): visible = false)
	Messenger.PLAYER_THRUSTAPPLIED.connect(show_engines)
	Messenger.PLAYER_STOPENGINE.connect(stop_engine)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_engines():
	if !$engine.is_playing():
		$engine.play()

	$booster.play()
	visible = true
	timer.start(0.5)

func stop_engine():
	$engine.stop()