extends Node2D

const WAIT_TIME = 2

@export var velocity: float = 1000.0
@export var damage: float = 5.0

#@onready var _timer: Timer = $Timer
@onready var _visibility_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var _detection_area: DetectionArea = $DetectionArea


func _ready():
	_detection_area.entered.connect(_on_entered)
	_visibility_notifier.screen_exited.connect(_on_screen_exited)
	set_as_top_level(true)

func _physics_process(delta) -> void:
	global_position += Vector2.RIGHT.rotated(rotation) * velocity * delta	


func hit() -> void:
	var enemy: Enemy = _detection_area.enemy
	enemy.take_damage(damage)


func _on_entered() -> void:
	hit()
	queue_free()

func _on_screen_exited() -> void:
	queue_free()
