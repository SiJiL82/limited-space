extends RigidBody3D

@export var camera: Camera3D
@export var thrust: int = 5
@export_range(0, 1) var rotate_speed: float = 0
@export var rescue_point: Node3D

@onready var storage = $Storage

var fuel: Node3D
var game_active: bool = false
var unloading_astronauts: bool = false
var player_started_game = false

func _ready():
	fuel = get_node("Fuel")
	Messenger.WORLD_INITGAME.connect(init_player)
	Messenger.STARTPANEL_STARTGAME.connect(func(): game_active = true)
	Messenger.ASTRONAUT_COLLIDED.connect(pickup_astronaut)
	Messenger.LOSEPANEL_RESETGAME.connect(func(): linear_velocity = Vector3.ZERO)
	Messenger.WORLD_ENDGAME.connect(func(): game_active = false)

func _physics_process(_delta):
	if game_active:
		if unloading_astronauts:
			move_to_rescue_area()
		else:
			look_at_mouse()
			if Input.is_action_just_pressed("thruster"):
				player_started_game = true
				if fuel.has_fuel():
					apply_thrust()
			check_for_lose_conditions()

func init_player(player_spawn):
	player_started_game = false
	position = player_spawn
	unloading_astronauts = false
	game_active = true

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
		$pick_up_fx.play()
		Messenger.PLAYER_PICKEDUPASTRONAUT.emit()
		astronaut.queue_free()

func check_for_lose_conditions():
	if check_if_out_of_bounds():
		Messenger.PLAYER_LOSTGAME.emit()
	if is_close_to_zero(linear_velocity.x) and is_close_to_zero(linear_velocity.z) and !fuel.has_fuel():
		Messenger.PLAYER_LOSTGAME.emit()

func is_close_to_zero(value) -> bool:
	var slow_speed: float = 0.3
	if value > -slow_speed and value < slow_speed:
		return true
	return false

func _on_rescue_area_area_entered(_area):
	
	if storage.get_value():
		unloading_astronauts = true

func _on_rescue_area_area_exited(_area):
	Messenger.PLAYER_LEFTRESCUEAREA.emit()

func move_to_rescue_area():
	var target_direction = transform.origin.direction_to(rescue_point.global_position)
	var target_distance = transform.origin.distance_to(rescue_point.global_position)
	linear_velocity = target_direction.normalized() * 4
	if !$landing.is_playing():
		Messenger.PLAYER_STOPENGINE.emit()
		$landing.play()
	if target_distance < 1.0:
		linear_velocity = Vector3.ZERO
		Messenger.PLAYER_DROPOFFASTRONAUT.emit(storage.get_value())
		unloading_astronauts = false
		Messenger.PLAYER_ENTEREDRESCUEAREA.emit()
		$drop_off_fx.play()


func check_if_out_of_bounds():
	var top_left = camera.project_position(Vector2(0,0), 150)
	var bottom_right = camera.project_position(Vector2(1920, 1080), 150)
	var buffer: int = 30

	if global_transform.origin.x < (top_left.x - buffer):
		return true
	
	if global_transform.origin.z < (top_left.z - buffer) :
		return true
	
	if global_transform.origin.x > (bottom_right.x + buffer):
		return true
	
	if global_transform.origin.z > (bottom_right.z + buffer):
		return true
	
	return false
