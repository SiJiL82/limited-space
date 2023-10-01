extends Button

signal StartGame()

# Called when the node enters the scene tree for the first time.
func _pressed():
	StartGame.emit()
