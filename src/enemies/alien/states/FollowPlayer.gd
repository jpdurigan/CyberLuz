extends AutoForwardState

export var player_area_path: NodePath
onready var _player_area: Area2D = get_node(player_area_path)
export var attack_area_path: NodePath
onready var _attack_area: Area2D = get_node(attack_area_path)

onready var _alien : KinematicBody2D = owner as KinematicBody2D


func physics_process(delta: float):
	_alien.target = _get_player_position()


func should_transition_to() -> String:
	if _attack_area.get_overlapping_areas().size() > 0:
		return "AttackPlayer"
	if _player_area.get_overlapping_bodies().size() == 0:
		return "Wander"
	return ""


func _get_player_position() -> Vector2:
	if _player_area.get_overlapping_bodies().size() != 1:
		return _alien.global_position
	else:
		return _player_area.get_overlapping_bodies().front().global_position
