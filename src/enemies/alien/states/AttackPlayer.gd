extends AutoForwardState

export var damage: float = 15.0
export var rate: float = 1

export var attack_area_path: NodePath
onready var _attack_area: Area2D = get_node(attack_area_path)

onready var _timer: Timer = $Timer
onready var _alien : KinematicBody2D = owner as KinematicBody2D


func enter(msg: Dictionary) -> void:
	_timer.connect("timeout", self, "_on_timer_timeout")
	_attack_area.connect("player_exited", self, "_on_attack_area_player_exited")
	attack()

func exit() -> Dictionary:
	_attack_area.disconnect("player_exited", self, "_on_attack_area_player_exited")
	return {}


func attack() -> void:
	if _attack_area.player:
		_attack_area.player.take_damage(damage)
	_timer.wait_time = _get_wait_time()
	_timer.start()


func _get_wait_time() -> float:
	return 1.0 / rate

func _on_attack_area_player_exited() -> void:
	transition_to("FollowPlayer")

func _on_timer_timeout() -> void:
	attack()
