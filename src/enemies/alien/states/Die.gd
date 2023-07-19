extends AutoForwardState

@export var items: Array = [] # (Array, PackedScene)
@export var chance: float = 0.2

@onready var _alien : Enemy = owner as CharacterBody2D


func _ready():
	_alien.connect("is_dead", Callable(self, "_on_alien_is_dead"))


func enter(_msg: Dictionary) -> void:
	spawn_item()
	call_deferred("_queue_free")


func spawn_item() -> void:
	if (items.is_empty() or chance <= 0.0):
		return
	
	var should_spawn: bool = randf() <= chance
	if should_spawn:
# warning-ignore:narrowing_conversion
		var random_idx: int = floor(randf_range(0, items.size()))
		var random_item_scene: PackedScene = items[random_idx]
		
		var random_item: Item = random_item_scene.instantiate()
		random_item.global_position = _alien.global_position
		Global.item_spawner.call_deferred("add_child", random_item)


func _queue_free() -> void:
	_alien.queue_free()

func _on_alien_is_dead() -> void:
	transition_to("Die")
