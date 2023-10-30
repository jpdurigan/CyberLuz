extends Node

@export var enemy_scene: PackedScene

var score

@onready var player = get_node("Player")

@export var enemy_speed = 300

func _ready() -> void:
	Global.parent_node_creation = self
	randomize()
	new_game()

func _exit_tree():
	Global.parent_node_creation = null

func new_game():
	$StartTimer.start()
	
func _on_MobTimer_timeout():
	var enemy = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var enemy_spawn_location = get_node("EnemyPath/SpawnPoint")
	enemy_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	enemy.position = enemy_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	#player position

	# Spawn the mob by
	add_child(enemy)

func _on_StartTimer_timeout():
	$MobTimer.start()

