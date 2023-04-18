extends KinematicBody2D

# Variáveis fixas
var life_current = 100
var screen_size
#Variaveis exportadas
export var speed = 150;
export var life_max = 100;


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	_movement()

#Função Movimento
func _movement():
#variaveis de movimentação
	var h_move = Input.get_axis("ui_left", "ui_right")
	var v_move = Input.get_axis("ui_up", "ui_down")
	var input_vector = Vector2(h_move, v_move)
		
	if Input.is_action_just_pressed("shoot"):
		_shooting()
		
	move_and_slide(input_vector * speed) 


func _shooting():
	pass
#	var bullet = bullet_scene.instance()
#	get_tree().current_scene.add_child(bullet)
#	bullet.position = $Aim.global_position
#
#	if _animated_sprite.animation == "right":
#		bullet.rotation_degrees = 180
#	if	_animated_sprite.animation == "left":
#		bullet.rotation_degrees = 0
#	if _animated_sprite.animation == "down":
#		bullet.rotation_degrees = 270

