extends Label

@export var storage: Storage

var text_prefix: String = "Astronauts in ship: "

func _ready():
	Messenger.PLAYER_PICKEDUPASTRONAUT.connect(update_label)
	update_label()

func update_label():
	set_text(text_prefix + str(storage.get_value()) + "/" + str(storage.get_capacity()))
