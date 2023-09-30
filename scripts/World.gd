extends Node3D

@export var num_astronauts: int = 4

var StrandedAstronaut = preload("res://assets/Scenes/astronaut_floating.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_astronauts(num_astronauts)

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

	while spawnX > -20 and spawnX < 20:
		spawnX = rng.randf_range(-width, width)
	while spawnZ > -10 and spawnZ < 10:
		spawnZ = rng.randf_range(-height, height)
	print(Vector3(spawnX, 0, spawnZ))
	return Vector3(spawnX, 0, spawnZ)
