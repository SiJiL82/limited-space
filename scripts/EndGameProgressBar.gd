extends ProgressBar

var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.WORLD_ENDGAMETIMERSTARTED.connect(timer_started)
	Messenger.WORLD_ENDGAMETIMERSTOPPED.connect(timer_stopped)

func _process(_delta):
	if timer and !timer.is_stopped():
		value = timer.time_left

func timer_started(_value):
	timer = _value
	max_value = timer.time_left
	value = timer.time_left
	visible = true

func timer_stopped():
	visible = false
