extends AutoForwardState

export var attack_area_path: NodePath
onready var _attack_area: Area2D = get_node(attack_area_path)

onready var _alien : KinematicBody2D = owner as KinematicBody2D


func should_transition_to() -> String:
	if _attack_area.get_overlapping_areas().size() == 0:
		return "FollowPlayer"
	return ""
