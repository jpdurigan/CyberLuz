extends TextureButton


func _ready():
	connect("pressed", self, "_on_pressed")


func _on_pressed():
	Global.set_game_paused_mode()