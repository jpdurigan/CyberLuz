extends Node

var item_spawner: Node2D = null

@onready var state_machine: StateMachine = $StateMachine

func set_game_mode() -> void:
	state_machine.transition_to("Game")

func set_game_paused_mode() -> void:
	state_machine.transition_to("Game/Paused")

func set_game_config_mode() -> void:
	state_machine.transition_to("Game/Config")

func exit() -> void:
	get_tree().quit()


var MASTER_BUS = AudioServer.get_bus_index("Master")

var is_mute: bool = false
var master_volume_db: float = 0.0
@onready var bgm_player: AudioStreamPlayer = $BGM

func set_audio_master_mute(p_is_mute: bool) -> void:
	is_mute = p_is_mute
	AudioServer.set_bus_mute(MASTER_BUS, is_mute)
	if is_mute and bgm_is_playing():
		bgm_stop()
	elif !is_mute and bgm_should_play():
		bgm_play()

func set_audio_master_volume(volume_db: float) -> void:
	master_volume_db = volume_db
	AudioServer.set_bus_volume_db(MASTER_BUS, volume_db)

func bgm_play(bgm: AudioStream = null) -> void:
	if bgm != null and bgm_player.stream != bgm:
		bgm_player.stream = bgm
	if !is_mute and !bgm_is_playing():
		bgm_player.play()

func bgm_stop() -> void:
	bgm_player.stop()

func bgm_is_playing() -> bool:
	return bgm_player.playing

func bgm_should_play() -> bool:
	return state_machine.is_current_state("Game")
