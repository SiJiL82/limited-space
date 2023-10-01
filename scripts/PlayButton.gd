extends Button

func _pressed():
	Messenger.STARTPANEL_STARTGAME.emit()
