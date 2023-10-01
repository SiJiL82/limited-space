extends Node3D

@export var fuel: int = 20
var max_fuel = fuel;
var refuel_values = [0, 10, 15, 20]

func _ready():
	Messenger.FUEL_MAXFUELSET.emit(fuel)
	Messenger.PLAYER_DROPOFFASTRONAUT.connect(add_fuel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("thruster"):
		# Check if we have fuel, decrement it if so
		if has_fuel():
			fuel -= 1
			Messenger.FUEL_FUELCHANGED.emit(fuel)

func has_fuel() -> bool:
	if fuel > 0:
		return true
	return false

func add_fuel(astronauts_in_storage):
	var fuel_to_add = refuel_values[astronauts_in_storage]

	#Ensures fuel doesn't go over max.
	if(fuel_to_add + fuel >= max_fuel):
		fuel = max_fuel
	else:
		fuel += fuel_to_add
	
	Messenger.FUEL_FUELCHANGED.emit(fuel)