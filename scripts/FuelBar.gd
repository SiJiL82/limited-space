extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.FuelChanged.connect(update_fuel_display)
	Messenger.MaxFuelSet.connect(set_max_fuel)
	value = max_value

func update_fuel_display(_value):
	value = _value

func set_max_fuel(_value):
	max_value = _value
