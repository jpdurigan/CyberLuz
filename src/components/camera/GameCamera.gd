extends Camera2D

export var target_path: NodePath
onready var target: Node2D = get_node_or_null(target_path) as Node2D


func _ready():
	if (target):
		global_position = target.global_position

func _physics_process(delta):
	if (target):
		global_position = lerp(global_position, target.global_position, 0.5)
