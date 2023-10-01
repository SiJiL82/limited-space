extends Node3D

@export var num_astronauts: int = 4
@export var player: RigidBody3D
@export var player_spawn: Node3D

var StrandedAstronaut = preload("res://assets/Scenes/astronaut_floating.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Messenger.LOSEPANEL_RESETGAME.connect(init_game)
	init_game()

func spawn_astronauts(astronauts_to_spawn):
	for i in astronauts_to_spawn:
		spawn_astronaut()

func spawn_astronaut():
	var spawnedAstronaut = StrandedAstronaut.instantiate()
	spawnedAstronaut.position = generate_random_location()
	self.add_child(spawnedAstronaut)
	var animation_player = spawnedAstronaut.get_node("astronautA").get_node("AnimationPlayer")
	animation_player.play("spinning")

func generate_random_location():
	var width = -180
	var height = -100
	var spawnX = 0
	var spawnZ = 0

	var nospawn_x = 25
	var nospawn_z = 15

	while spawnX > -nospawn_x and spawnX < nospawn_x:
		spawnX = rng.randf_range(-width, width)
	while spawnZ > -nospawn_z and spawnZ < nospawn_z:
		spawnZ = rng.randf_range(-height, height)
	
	return Vector3(spawnX, 0, spawnZ)

func position_player():
	player.position = player_spawn.position
	player.rotate_object_local(Vector3(0, 1, 0), deg_to_rad(90))

func remove_astronauts():
	for astronaut in get_tree().get_nodes_in_group("Astronauts"):
		astronaut.queue_free()

func init_game():
	remove_astronauts()
	spawn_astronauts(num_astronauts)
	position_player()
