class_name Player
extends KinematicBody2D

const ANIM_WALK_BLEND_POSITION = "parameters/state_machine/walk/blend_position"
const ANIM_IDLE_BLEND_POSITION = "parameters/state_machine/idle/blend_position"
const ANIM_DAMAGE_BLEND_POSITION = "parameters/state_machine/damage/blend_position"
const ANIM_STATE_MACHINE_PLAYBACK = "parameters/state_machine/playback"

export(float, 0.0, 500.0, 10.0) var speed_max: float = 150.0
export(float, 0.0, 500.0, 10.0) var speed_min: float = 30.0
export(float, 0.0, 500.0, 10.0) var accerelation: float = 100.0
export(float, 0.0, 250.0, 10.0) var life_max: float = 100.0

var _speed_current: float
var _life_current: float

onready var _animation_tree: AnimationTree = $AnimationTree
onready var _animation_state_machine: AnimationNodeStateMachinePlayback = _animation_tree.get(ANIM_STATE_MACHINE_PLAYBACK)

onready var _shooter: Shooter = $Shooter
onready var _untie_area: Area2D = $UntieArea

func _ready():
	_speed_current = speed_min
	_life_current = life_max
	HUD.update_health(_life_current, life_max, 0)

func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("shoot"):
		if _untie_area.has_overlapping_civil():
			_untie_area.civil.untie()
		else:
			_shooter.shoot()

func _physics_process(_delta):
	_move()


func take_damage(value: float) -> void:
	_life_current -= value
	if is_dead():
		queue_free()
	else:
		_animation_state_machine.travel("damage")
	HUD.update_health(_life_current, life_max)

func is_dead() -> bool:
	return _life_current <= 0


func _move():
	var input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	_animation_tree.set(ANIM_WALK_BLEND_POSITION, input_direction)
	if input_direction.length_squared() > 0:
		_animation_tree.set(ANIM_IDLE_BLEND_POSITION, input_direction.x)
		_animation_tree.set(ANIM_DAMAGE_BLEND_POSITION, input_direction.x)
		if _animation_state_machine.get_current_node() == "idle":
			_animation_state_machine.travel("walk")
		
		_speed_current += accerelation * get_physics_process_delta_time()
		_speed_current = min(_speed_current, speed_max)
	else:
		if _animation_state_machine.get_current_node() == "walk":
			_animation_state_machine.travel("idle")
		_speed_current = speed_min
	
	move_and_slide(input_direction * _speed_current)
