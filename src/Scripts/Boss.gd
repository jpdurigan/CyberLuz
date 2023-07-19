extends Area2D

@export var boss_life = 1

func _ready():
	$AnimationPlayer.play()
		
func damage():
	boss_life -= 1
	$AnimatedSprite2D.play("damage")

func death():
	if boss_life == 0:
		$Death/Particles_01.visible = true
		$Death/Particles_02.visible = true
		$Death.visible = true
		$AnimationPlayer.stop()
		$Sprite2D.visible = false
