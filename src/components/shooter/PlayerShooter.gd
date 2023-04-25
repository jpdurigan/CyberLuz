extends Shooter


func _should_shoot() -> bool:
	return false

func _aim():
	target = get_global_mouse_position()
	._aim()

func _on_timer_timeout():
	if Input.is_action_pressed("shoot"):
		_shoot()
