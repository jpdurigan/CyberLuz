class_name State
extends Node


func enter(_msg: Dictionary) -> void:
	pass

func exit() -> Dictionary:
	var msg := {}
	return msg


func unhandled_input(_event: InputEvent) -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
