extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.FUEL_FUELCHANGED.connect(func(_value): value = _value)
	Messenger.FUEL_MAXFUELSET.connect(func(_value): max_value = _value)
	value = max_value
