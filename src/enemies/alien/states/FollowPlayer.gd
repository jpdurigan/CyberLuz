extends AutoForwardState

@export var player_area_path: NodePath
@onready var _player_area: DetectionArea = get_node(player_area_path)
@export var attack_area_path: NodePath
@onready var _attack_area: DetectionArea = get_node(attack_area_path)

@onready var _alien : CharacterBody2D = owner as CharacterBody2D

func enter(_msg: Dictionary) -> void:
	if _player_area.player == null:
		transition_to("Wander")
		return
	
	_player_area.player_exited.connect(_on_player_area_player_exited)
	_attack_area.player_entered.connect(_on_attack_area_player_entered)

func exit() -> Dictionary:
	_player_area.player_exited.disconnect(_on_player_area_player_exited)
	_attack_area.player_entered.disconnect(_on_attack_area_player_entered)
	return {}


func physics_process(_delta: float):
	if _player_area.player:
		_alien.target = _player_area.player.global_position


func _on_player_area_player_exited() -> void:
	transition_to("Wander")

func _on_attack_area_player_entered() -> void:
	transition_to("AttackPlayer")
