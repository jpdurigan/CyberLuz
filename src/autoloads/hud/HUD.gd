extends CanvasLayer

onready var _game: Control = $Game
onready var _pause: Control = $PauseScreen
onready var _config: Control = $ConfigScreen


func _enter_tree():
	for child in get_children():
		child.hide()


func show_game_screen() -> void:
	_game.show()

func hide_game_screen() -> void:
	_game.hide()

func show_pause_screen() -> void:
	_pause.show()

func hide_pause_screen() -> void:
	_pause.hide()

func show_config_screen() -> void:
	_config.show()

func hide_config_screen() -> void:
	_config.hide()
