extends TextureButton

@onready var config = get_node("/root/CyberLuz/HUD/UI/ConfigScreen")

func _pressed():
    config.visible = false
