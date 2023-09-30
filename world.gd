extends Node3D

var StrandedAstronaut = preload("res://astronaut_floating.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():

	spawn_astronauts()

func spawn_astronauts():
	StrandedAstronaut.position = Vector3(0, 10, 0) #0, 20, 0 for centre.
	self.add_child(StrandedAstronaut)
	var animation_player = StrandedAstronaut.get_node("astronautA").get_node("AnimationPlayer")
	animation_player.play("spinning")
