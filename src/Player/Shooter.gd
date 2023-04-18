extends Node2D

export var bullet_scene: PackedScene
export var rate: float = 2

onready var _timer: Timer = $Timer


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")

func _unhandled_input(event):
	if event.is_action_pressed("shoot") and _can_shoot():
		_shoot()

func _physics_process(delta):
	_aim()


func _can_shoot() -> bool:
	return _timer.time_left == 0

func _get_wait_time() -> float:
	return 1.0 / rate


func _aim():
	look_at(get_global_mouse_position())

func _shoot():
	var bullet: Node2D = bullet_scene.instance()
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation
	add_child(bullet)
	
	_timer.wait_time = _get_wait_time()
	_timer.start()


func _on_timer_timeout():
	if Input.is_action_pressed("shoot"):
		_shoot()
