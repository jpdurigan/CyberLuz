extends Node2D

func _enter_tree():
	Global.item_spawner = self

func _exit_tree():
	Global.item_spawner = null
