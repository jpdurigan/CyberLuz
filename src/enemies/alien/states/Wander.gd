extends AutoForwardState

const MAX_DISTANCE = 20

export var wander_radius: float = 640.0
export var wait_time: float = 3.0
export(float, 0.0, 1.0, 0.1) var wait_randomness: float = 0.2

var _target: Vector2

onready var _timer : Timer = $Timer
onready var _alien : KinematicBody2D = owner as KinematicBody2D
onready var _initial_position : Vector2 = _alien.global_position


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")


func enter(msg: Dictionary) -> void:
	_pick_new_target()

func physics_process(delta: float):
	if !_is_waiting() and _is_at_target():
		_alien.target = _alien.global_position
		_timer.wait_time = _get_wait_time()
		_timer.start()


func _pick_new_target() -> void:
	var new_target = (
			_initial_position +
			Vector2.RIGHT.rotated(2 * PI * randf()) * wander_radius
	)
	
	_target = new_target
	_alien.target = _target

func _is_at_target() -> bool:
	return _alien.global_position.distance_to(_target) < MAX_DISTANCE

func _is_waiting() -> bool:
	return _timer.time_left > 0

func _get_wait_time() -> float:
	return wait_time * rand_range(1.0 - wait_randomness, 1.0 + wait_randomness)


func _on_timer_timeout() -> void:
	_pick_new_target()
