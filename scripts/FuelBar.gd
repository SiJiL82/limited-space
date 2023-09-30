extends ProgressBar

@export var fuel: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	fuel.FuelChanged.connect(update_fuel_display)
	max_value = fuel.fuel
	value = max_value

func update_fuel_display(_value):
	value = _value
