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


func _ready():
	_speed_current = speed_min
	_life_current = life_max

func _unhandled_input(_event):
	if Input.is_action_just_pressed("shoot"):
		_shooting()

func _physics_process(_delta):
	_move()


func _move():
	var input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	_animation_tree.set(ANIM_WALK_BLEND_POSITION, input_direction)
	if input_direction.length_squared() > 0:
		_animation_tree.set(ANIM_IDLE_BLEND_POSITION, input_direction.x)
		_animation_tree.set(ANIM_DAMAGE_BLEND_POSITION, input_direction.x)
		_animation_state_machine.travel("walk")
		
		_speed_current += accerelation * get_physics_process_delta_time()
		_speed_current = min(_speed_current, speed_max)
	else:
		_animation_state_machine.travel("idle")
		_speed_current = speed_min
	
	move_and_slide(input_direction * _speed_current)


func _shooting():
	pass
#	var bullet = bullet_scene.instance()
#	get_tree().current_scene.add_child(bullet)
#	bullet.position = $Aim.global_position
#
#	if _animated_sprite.animation == "right":
#		bullet.rotation_degrees = 180
#	if	_animated_sprite.animation == "left":
#		bullet.rotation_degrees = 0
#	if _animated_sprite.animation == "down":
#		bullet.rotation_degrees = 270

