class_name Shooter
extends Node2D

export var bullet_scene: PackedScene
export var rate: float = 2

var target: Vector2

onready var _timer: Timer = $Timer


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")

func _physics_process(_delta):
	_aim()
	if _should_shoot():
		_shoot()


func shoot() -> void:
	_shoot()

func _should_shoot() -> bool:
	return _timer.time_left == 0

func _get_wait_time() -> float:
	return 1.0 / rate


func _aim():
	look_at(target)

func _shoot():
	var bullet: Node2D = bullet_scene.instance()
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	add_child(bullet)
	
	_timer.wait_time = _get_wait_time()
	_timer.start()


func _on_timer_timeout():
	if _should_shoot():
		_shoot()
