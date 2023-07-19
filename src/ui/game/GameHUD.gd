extends Control

const UPDATE_HEALTH_DURATION = 0.35

@onready var _health_progress: TextureProgressBar = $PlayerHealth/Border/Progress
@onready var _health_tween: Tween = $PlayerHealth/Tween

func update_health(current_health: float, max_health: float, tween_duration: float = -1.0) -> void:
	if tween_duration < 0:
		tween_duration = UPDATE_HEALTH_DURATION
	
	_health_tween.stop_all()
	_health_tween.interpolate_property(
		_health_progress,
		"value",
		_health_progress.value,
		current_health,
		tween_duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	_health_tween.interpolate_property(
		_health_progress,
		"max_value",
		_health_progress.max_value,
		max_health,
		tween_duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	_health_tween.start()
