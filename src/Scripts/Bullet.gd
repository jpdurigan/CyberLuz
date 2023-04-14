extends Sprite

var mov = Vector2(1, 0)
export var velocity = 1000
var direction = true

func _process(delta: float) -> void:
	if direction:
		look_at(get_global_mouse_position())
		direction = false
	global_position += mov.rotated(rotation) * velocity * delta	


func _on_Notifier_screen_exited() -> void:
	queue_free()
