extends KinematicBody2D

export var damage = 1
export var bullet_speed = 200

func _ready():
	pass 
	
func _physics_process(delta):
	var direction = Vector2(cos(rotation), sin(rotation)).normalized()
	var movement = direction * bullet_speed
	move_and_slide(movement)
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage()
		body.death()
		queue_free()
	if body.is_in_group("Boss"):
		pass
		
		
		
