extends State

export var game_bgm: AudioStream

func enter(_msg: Dictionary) -> void:
	HUD.show_game_screen()
	Global.bgm_play(game_bgm)
