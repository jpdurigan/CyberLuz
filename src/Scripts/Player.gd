extends KinematicBody2D

var bullet_scene = load("res://Scenes/Bullet.tscn")
onready var value = get_node("/root/CyberLuz/HUD/UI/Player/HealthBar")

# Variáveis fixas
var life_current = 100
var screen_size
#Variaveis exportadas
export var speed = 150;
export var life_max = 100;
# Signals
signal hit

onready var _animated_sprite = $AnimatedSprite
onready var tween = $camera/tween as Tween

func _ready():
	screen_size = get_viewport_rect().size
		
func _physics_process(delta):
	_movement()
	
#func _process(delta) -> void:
	
func _on_Area2D_body_entered(Body):
	if Body.is_in_group("Enemy"):
		_animated_sprite.play("damage")
		value = life_current
		life_current -= 5
		
		
		print (life_current)
	if Body.is_in_group("Boss"):
		life_current -= 15
		

#Função Movimento
func _movement():
#variaveis de movimentação
	var h_move = Input.get_axis("ui_left", "ui_right")
	var v_move = Input.get_axis("ui_up", "ui_down")
	var input_vector = Vector2(h_move, v_move)
	
	if h_move != 0:
		if h_move > 1:
			_animated_sprite.play("left")
			$AnimatedSprite.flip_h = true
		else:
			_animated_sprite.play("left")
	if v_move != 0:
		if v_move > 1:
			_animated_sprite.play("left")
		else:
			_animated_sprite.play("down")
	
	elif h_move == 0 and v_move == 0:
		_animated_sprite.stop()	
		
	if Input.is_action_just_pressed("shoot"):
		_shooting()
		
		
	move_and_slide(input_vector * speed) 

func _shooting():
	var bullet = bullet_scene.instance()
	get_tree().current_scene.add_child(bullet)
	bullet.position = $Aim.global_position
	
	if _animated_sprite.animation == "right":
		bullet.rotation_degrees = 180
	if	_animated_sprite.animation == "left":
		bullet.rotation_degrees = 0
	if _animated_sprite.animation == "down":
		bullet.rotation_degrees = 270

func _zoomIn():
	tween.interpolate_property($camera, "zoom", Vector2(1.5, 1.5), Vector2(1, 1), 10, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func _zoomOut():
	tween.interpolate_property($camera, "zoom", Vector2(1, 1), Vector2(2, 2), 10, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

