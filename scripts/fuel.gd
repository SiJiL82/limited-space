extends Node3D

@export var fuel: int = 20

signal FuelChanged(fuel)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("thruster"):
		# Check if we have fuel, decrement it if so
		if has_fuel():
			fuel -= 1
			FuelChanged.emit(fuel)

func has_fuel() -> bool:
	if fuel > 0:
		return true
	return false
