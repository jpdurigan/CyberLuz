extends Button


func _ready():
	connect("pressed", Callable(self, "_on_pressed"))


func _on_pressed():
	Global.set_game_mode()
