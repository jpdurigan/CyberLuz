class_name StateMachine
extends Node


@export var start_node_path: NodePath

var state: State
var state_name: String

@onready var _start_node: State = get_node_or_null(start_node_path) as State


func _ready():
	var initial_msg := {}
	_start_node.enter(initial_msg)
	_set_state(_start_node)

func _unhandled_input(event):
	if state:
		state.unhandled_input(event)

func _process(delta):
	if state:
		state.process(delta)

func _physics_process(delta):
	if state:
		state.physics_process(delta)


func transition_to(state_path: String) -> void:
	var next_state := get_node_or_null(state_path) as State
	if next_state == null:
		return
	
	var msg := state.exit()
	next_state.enter(msg)
	_set_state(next_state)

func is_current_state(p_name: String) -> bool:
	return p_name in state_name


func _set_state(p_state: State) -> void:
	state = p_state
	state_name = get_path_to(state)
