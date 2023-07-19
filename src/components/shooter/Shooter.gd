class_name Shooter
extends Node2D

@export var bullet_scene: PackedScene
@export var rate: float = 2

var target: Vector2

@export var pivot_node_path := NodePath(".")
@onready var _pivot_node: Node2D = get_node(pivot_node_path) as Node2D
@onready var _timer: Timer = $Timer


func _ready():
	_timer.connect("timeout", Callable(self, "_on_timer_timeout"))

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
	_pivot_node.look_at(target)

func _shoot():
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	add_child(bullet)
	
	_timer.wait_time = _get_wait_time()
	_timer.start()


func _on_timer_timeout():
	if _should_shoot():
		_shoot()
