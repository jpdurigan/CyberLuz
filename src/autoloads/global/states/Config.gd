extends State


func enter(_msg: Dictionary) -> void:
	HUD.show_config_screen()
	get_tree().paused = true

func exit() -> Dictionary:
	HUD.hide_config_screen()
	get_tree().paused = false
	return {}
