extends Node3D

@export var min_rotate_speed: float = 0.001
@export var max_rotate_speed: float = 0.03

var rotate_direction = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)).normalized()
var rotate_speed = randf_range(min_rotate_speed, max_rotate_speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = randf_range(0, TAU)
	var y = randf_range(0, TAU)
	var z = randf_range(0, TAU)
	rotation = Vector3(x, y, z)

func _process(_delta):
	rotate_object_local(rotate_direction, rotate_speed)
