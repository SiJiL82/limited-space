extends RigidBody3D

@export var camera: Camera3D
@export var thrust: int = 5
@export_range(0, 1) var rotate_speed: float = 0

@onready var storage = $Storage

var fuel: Node3D
var game_active: bool = false

func _ready():
	fuel = get_node("Fuel")
	Messenger.STARTPANEL_STARTGAME.connect(func(): game_active = true)
	Messenger.ASTRONAUT_COLLIDED.connect(pickup_astronaut)

func _physics_process(_delta):
	if game_active:
		look_at_mouse()
		if Input.is_action_just_pressed("thruster"):
			if fuel.has_fuel():
				apply_thrust()


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
