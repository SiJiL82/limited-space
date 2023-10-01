extends Node

var astronauts_picked_up = 0

func increment_astronaut_pick_up_count():
	astronauts_picked_up += 1

func get_astronaut_pick_up_count():
	return astronauts_picked_up