extends TextureButton

onready var pause = get_node("/root/CyberLuz/HUD/UI/PauseScreen")

func _pressed():
    pause.visible = false

