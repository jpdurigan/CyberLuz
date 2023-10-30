extends Item

@export var health: float = 30.0

func effect() -> void:
	var player := _detection_area.get_overlapping_player()
	player.add_health(health)
