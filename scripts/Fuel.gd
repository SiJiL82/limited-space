extends Node3D

@export var max_fuel: int = 20
var fuel
var refuel_values = [0, 2, 4, 8]

func _ready():
	reset_fuel()
	Messenger.FUEL_MAXFUELSET.emit(fuel)
	Messenger.LOSEPANEL_RESETGAME.connect(reset_fuel)
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

func reset_fuel():
	fuel = max_fuel
	Messenger.FUEL_FUELCHANGED.emit(fuel)

func add_fuel(astronauts_in_storage):
	var fuel_to_add = refuel_values[astronauts_in_storage]

	#Ensures fuel doesn't go over max.
	if(fuel_to_add + fuel >= max_fuel):
		fuel = max_fuel
	else:
		fuel += fuel_to_add
	
	Messenger.FUEL_FUELCHANGED.emit(fuel)
