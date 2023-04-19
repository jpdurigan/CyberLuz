class_name Enemy
extends KinematicBody2D

const ANIM_WALK_BLEND_POSITION = "parameters/state_machine/walk/blend_position"
const ANIM_IDLE_BLEND_POSITION = "parameters/state_machine/idle/blend_position"
const ANIM_DAMAGE_BLEND_POSITION = "parameters/state_machine/damage/blend_position"
const ANIM_STATE_MACHINE_PLAYBACK = "parameters/state_machine/playback"

export(float, 0.0, 500.0, 10.0) var speed_max: float = 150.0
export(float, 0.0, 500.0, 10.0) var accerelation: float = 100.0
export(float, 0.0, 200.0, 1.0) var max_distance: float = 36.0
export(float, 0.0, 250.0, 10.0) var life_max: float = 100.0

export var target: Vector2

var is_at_target: bool = false

var _speed_current: float
var _life_current: float

onready var _animation_tree: AnimationTree = $AnimationTree
onready var _animation_state_machine: AnimationNodeStateMachinePlayback = _animation_tree.get(ANIM_STATE_MACHINE_PLAYBACK)


func _ready():
	_speed_current = 0.0
	_life_current = life_max

func _physics_process(_delta):
	_move()


func _move():
	var distance_to_target = global_position.distance_to(target)
	var direction = global_position.direction_to(target)
	
	if distance_to_target > max_distance:
		_animation_tree.set(ANIM_WALK_BLEND_POSITION, direction.x)
		_animation_tree.set(ANIM_IDLE_BLEND_POSITION, direction.x)
		_animation_tree.set(ANIM_DAMAGE_BLEND_POSITION, direction.x)
		_animation_state_machine.travel("walk")
		
		_speed_current += accerelation * get_physics_process_delta_time()
		_speed_current = min(_speed_current, speed_max)
		is_at_target = false
	else:
		_animation_state_machine.travel("idle")
		_speed_current = 0.0
		is_at_target = true
	
	move_and_slide(direction * _speed_current)
