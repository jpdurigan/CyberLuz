extends AutoForwardState

export(Array, PackedScene) var items: Array = []
export var chance: float = 0.2

onready var _alien : Enemy = owner as KinematicBody2D


func _ready():
	_alien.connect("is_dead", self, "_on_alien_is_dead")


func enter(msg: Dictionary) -> void:
	spawn_item()
	call_deferred("_queue_free")


func spawn_item() -> void:
	if (items.empty() or chance <= 0.0):
		return
	
	var should_spawn: bool = randf() <= chance
	if should_spawn:
		var random_idx: int = floor(rand_range(0, items.size()))
		var random_item_scene: PackedScene = items[random_idx]
		
		var random_item: Item = random_item_scene.instance()
		random_item.global_position = _alien.global_position
		Global.item_spawner.add_child(random_item)


func _queue_free() -> void:
	_alien.queue_free()

func _on_alien_is_dead() -> void:
	transition_to("Die")
