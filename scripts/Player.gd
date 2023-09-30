extends RigidBody3D

@export var camera: Camera3D
@export var thrust: int = 5
@export var engine_particles: GPUParticles3D

func _physics_process(_delta):
	look_at_mouse()
	if Input.is_action_just_pressed("thruster"):
		apply_thrust()


func look_at_mouse():
	var player_pos = global_transform.origin
	var drop_plane = Plane(Vector3(0, 1, 0), player_pos.y)

	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = drop_plane.intersects_ray(from, to)

	look_at(cursor_pos, Vector3.UP)

func apply_thrust():
	print(global_transform.basis)
	apply_impulse(-global_transform.basis.z * thrust)
