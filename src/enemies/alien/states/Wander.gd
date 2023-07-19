extends AutoForwardState

@export var wander_radius: float = 640.0
@export var wait_time: float = 3.0
@export var wait_randomness: float = 0.2 # (float, 0.0, 1.0, 0.1)

@export var player_area_path: NodePath
@onready var _player_area: DetectionArea = get_node(player_area_path)

var _target: Vector2

@onready var _timer : Timer = $Timer
@onready var _alien : Enemy = owner as CharacterBody2D
@onready var _initial_position : Vector2 = _alien.global_position


func enter(_msg: Dictionary) -> void:
	_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	_player_area.connect("player_entered", Callable(self, "_on_player_area_player_entered"))
	_pick_new_target()

func exit() -> Dictionary:
	_timer.disconnect("timeout", Callable(self, "_on_timer_timeout"))
	_player_area.disconnect("player_entered", Callable(self, "_on_player_area_player_entered"))
	return {}


func physics_process(_delta: float):
	if !_is_waiting() and _alien.is_at_target:
		_timer.wait_time = _get_wait_time()
		_timer.start()


func _pick_new_target() -> void:
	var new_target = (
			_initial_position +
			Vector2.RIGHT.rotated(2 * PI * randf()) * wander_radius
	)
	
	_target = new_target
	_alien.target = _target

func _is_waiting() -> bool:
	return _timer.time_left > 0

func _get_wait_time() -> float:
	return wait_time * randf_range(1.0 - wait_randomness, 1.0 + wait_randomness)


func _on_timer_timeout() -> void:
	_pick_new_target()

func _on_player_area_player_entered() -> void:
	transition_to("FollowPlayer")
