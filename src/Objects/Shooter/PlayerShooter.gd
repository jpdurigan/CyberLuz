extends Shooter

func _unhandled_input(event):
	if _should_shoot():
		_shoot()


func _should_shoot() -> bool:
	return ._should_shoot() and Input.is_action_pressed("shoot")


func _aim():
	target = get_global_mouse_position()
	._aim()
