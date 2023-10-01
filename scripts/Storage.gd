extends Node3D
class_name Storage

@export var capacity: int = 3
var value = 0

func _ready():
	Messenger.PLAYER_PICKEDUPASTRONAUT.connect(func(): value += 1)

func has_space() -> bool:
	if value < capacity:
		return true
	return false

func get_value():
	return value

func get_capacity():
	return capacity
