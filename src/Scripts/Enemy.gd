extends KinematicBody2D

export var life = 3
export var damage = 5
export var speed = 250

#onready var player : KinematicBody2D = get_tree().root.find_node("Player", true)
onready var player : KinematicBody2D = get_node("/root/CyberLuz/Player")

func _physics_process(delta):
	follow_player()
	
func _ready():
	$AnimatedSprite.play("run")
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func follow_player():
	if player != null:
		var direction = (player.position - self.get_position()).normalized()
		var movement = (direction * speed)
		move_and_slide(movement)
		
func damage():
	life -= 1
	$AnimatedSprite.play("damage")

func death():
	if life == 0:
		$AnimatedSprite.play("death")
		queue_free()
