extends Node3D
class_name Storage

@export var capacity: int = 3
var value = 0

func _ready():
	value = 0
	Messenger.PLAYER_PICKEDUPASTRONAUT.connect(increment_value)
	Messenger.PLAYER_DROPOFFASTRONAUT.connect(empty)

func increment_value():
	value += 1
	Messenger.STORAGE_VALUECHANGED.emit()

func has_space() -> bool:
	if value < capacity:
		return true
	return false

func get_value():
	return value

func get_capacity():
	return capacity

func empty(_empty):
	value = 0
	Messenger.STORAGE_VALUECHANGED.emit()