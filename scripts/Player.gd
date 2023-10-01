extends RigidBody3D

@export var camera: Camera3D
@export var thrust: int = 5
@export var play_button: Button

var global = preload("res://scripts/Global.gd").new()
@onready var astronauts_picked_up_label = get_node("/root/World/UI/AstronautsPickedUpContainer/AstronautsPickedUpLabel")

var fuel: Node3D
var game_active: bool = false
signal ThrustApplied()

var has_space = true

func _ready():
	fuel = get_node("Fuel")
	play_button.StartGame.connect(set_game_active)

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

	look_at(cursor_pos, Vector3.UP)

func apply_thrust():
	apply_impulse(-global_transform.basis.z * thrust)
	ThrustApplied.emit()

func set_game_active():
	game_active = true

func pickup_astronaut():
	if has_space:
		global.increment_astronaut_pick_up_count()
		if global.astronauts_picked_up >= 3:
			has_space = false
		astronauts_picked_up_label.update_label(global.get_astronaut_pick_up_count())