extends AutoForwardState

export var attack_area_path: NodePath
onready var _attack_area: Area2D = get_node(attack_area_path)

onready var _alien : KinematicBody2D = owner as KinematicBody2D


func enter(msg: Dictionary) -> void:
	_attack_area.connect("player_exited", self, "_on_attack_area_player_exited")

func exit() -> Dictionary:
	_attack_area.disconnect("player_exited", self, "_on_attack_area_player_exited")
	return {}


func _on_attack_area_player_exited() -> void:
	transition_to("FollowPlayer")
