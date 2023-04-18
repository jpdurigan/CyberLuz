class_name State
extends Node


func enter(msg: Dictionary) -> void:
	pass

func exit() -> Dictionary:
	var msg := {}
	return msg


func unhandled_input(event: InputEvent) -> void:
	pass

func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	pass
