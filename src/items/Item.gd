class_name Item
extends Node2D

@onready var _detection_area: DetectionArea = $DetectionArea

func _ready():
	_detection_area.player_entered.connect(_on_player_entered)

func effect() -> void:
	pass

func _on_player_entered() -> void:
	effect()
	queue_free()
