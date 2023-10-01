extends Node3D

@export var min_rotate_speed: float = 0.001
@export var max_rotate_speed: float = 0.03

var rotate_direction = Vector3(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1)).normalized()
var rotate_speed = randf_range(min_rotate_speed, max_rotate_speed)

func _process(_delta):
	rotate_object_local(rotate_direction, rotate_speed)

func _on_area_3d_body_entered(_body):
	Messenger.ASTRONAUT_COLLIDED.emit(self)
