extends Node3D

@export var starting_fuel: int = 20
var fuel

func _ready():
	reset_fuel()
	Messenger.FUEL_MAXFUELSET.emit(fuel)
	Messenger.LOSEPANEL_RESETGAME.connect(reset_fuel)

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
	fuel = starting_fuel
