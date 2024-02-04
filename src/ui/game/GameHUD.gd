extends Control

const UPDATE_HEALTH_DURATION = 0.35

var _health_tween: Tween = null

@onready var _health_progress: TextureProgressBar = $PlayerHealth/Border/Progress


func update_health(current_health: float, max_health: float, tween_duration: float = -1.0) -> void:
	if tween_duration < 0:
		tween_duration = UPDATE_HEALTH_DURATION
	
	if _health_tween != null:
		_health_tween.kill()
	
	_health_tween = create_tween()
	
	_health_tween.parallel()
	_health_tween.tween_property(_health_progress, "value", current_health, tween_duration) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	_health_tween.tween_property(_health_progress, "max_value", max_health, tween_duration) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	_health_tween.play()
