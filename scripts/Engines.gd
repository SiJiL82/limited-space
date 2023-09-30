extends Node3D

@export var timer: Timer

func _ready():
	timer.connect("timeout", on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("thruster"):
		visible = true
		timer.start(0.5)

func on_timer_timeout():
	visible = false

