extends Node3D

@export var timer: Timer
@export var player: RigidBody3D

func _ready():
	timer.connect("timeout", on_timer_timeout)
	player.ThrustApplied.connect(show_engines)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_engines():
	visible = true
	timer.start(0.5)

func on_timer_timeout():
	visible = false
