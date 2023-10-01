extends RigidBody3D

@export var camera: Camera3D
@export var thrust: int = 5
@export_range(0, 1) var rotate_speed: float = 0
@export var rescue_point: Node3D

@onready var storage = $Storage

var fuel: Node3D
var game_active: bool = false
var unloading_astronauts: bool = false
var is_docked: bool = false

func _ready():
	fuel = get_node("Fuel")
	Messenger.STARTPANEL_STARTGAME.connect(func(): game_active = true)
	Messenger.ASTRONAUT_COLLIDED.connect(pickup_astronaut)

func _physics_process(_delta):
	if game_active:
		if unloading_astronauts:
			move_to_rescue_area()
		else:
			look_at_mouse()
			if Input.is_action_just_pressed("thruster"):
				if fuel.has_fuel():
					apply_thrust()
			check_for_lose_conditions()

func look_at_mouse():
	var player_pos = global_transform.origin
	var drop_plane = Plane(Vector3(0, 1, 0), player_pos.y)

	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = drop_plane.intersects_ray(from, to)

	# Interpolate the rotation towards the mouse pointer
	transform = transform.interpolate_with(
		transform.looking_at(cursor_pos, Vector3.UP),
		rotate_speed
	)

func apply_thrust():
	apply_impulse(-global_transform.basis.z * thrust)
	Messenger.PLAYER_THRUSTAPPLIED.emit()

func pickup_astronaut(astronaut):
	if storage.has_space():
		Messenger.PLAYER_PICKEDUPASTRONAUT.emit()
		astronaut.queue_free()

func check_for_lose_conditions():
	if is_close_to_zero(linear_velocity.x) and is_close_to_zero(linear_velocity.z) and !fuel.has_fuel():
		Messenger.PLAYER_LOSTGAME.emit()

func is_close_to_zero(value) -> bool:
	if value > -0.1 and value < 0.1:
		return true
	return false

func _on_rescue_area_area_entered(_area):	
	if storage.get_value():
		unloading_astronauts = true

func move_to_rescue_area():
	var target_direction = transform.origin.direction_to(rescue_point.global_position)
	var target_distance = transform.origin.distance_to(rescue_point.global_position)
	linear_velocity = target_direction.normalized() * 4
	if target_distance < 1.0:
		linear_velocity = Vector3.ZERO
		Messenger.PLAYER_DROPOFFASTRONAUT.emit(storage.get_value())
		unloading_astronauts = false
