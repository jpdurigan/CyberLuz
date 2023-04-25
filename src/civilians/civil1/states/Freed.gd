extends State

onready var civil: Civil = owner as Civil

func enter(msg: Dictionary) -> void:
	civil._animation_state_machine.travel("release")
	pass
