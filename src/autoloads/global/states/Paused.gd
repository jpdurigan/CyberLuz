extends State


func enter(msg: Dictionary) -> void:
	HUD.show_pause_screen()
	get_tree().paused = true

func exit() -> Dictionary:
	HUD.hide_pause_screen()
	get_tree().paused = false
	return {}
