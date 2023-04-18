class_name AutoForwardState
extends State

onready var _state_machine: StateMachine = _get_state_machine()


func process(delta: float) -> void:
	var next_state := should_transition_to()
	if !next_state.empty():
		_state_machine.transition_to(next_state)
		return


func should_transition_to() -> String:
	return ""


func _get_state_machine(node: Node = self) -> StateMachine:
	if node is StateMachine:
		return node as StateMachine
	elif node.get_parent() != null:
		return _get_state_machine(node.get_parent())
	else:
		return null
