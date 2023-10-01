extends Button

func _pressed():
	Messenger.LOSEPANEL_RESETGAME.emit()

