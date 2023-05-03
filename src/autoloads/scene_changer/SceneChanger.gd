extends CanvasLayer

var _loader: ResourceInteractiveLoader = null
var _scene_path: String = ""

onready var _progress: ProgressBar = $Control/ProgressBar
onready var _tween: Tween = $Tween

func _ready():
	set_process(false)
	_progress.value = 0
	_progress.hide()

func _process(_delta):
	if _loader:
		var err = _loader.poll()
		_update_progress()
		if err == ERR_FILE_EOF:
			_on_load_success()
		elif err != OK:
			push_error(
				"Algo deu errado ao carregar a cena: %s | Erro: %s"
				% [_scene_path, err]
			)
	else:
		set_process(false)


func change_to(scene_path: String) -> void:
	_scene_path = scene_path
	_loader = ResourceLoader.load_interactive(scene_path, "PackedScene")
	_progress.value = 0
	_progress.show()
	set_process(true)


func _on_load_success() -> void:
	var next_scene: PackedScene = _loader.get_resource()
	get_tree().change_scene_to(next_scene)
	_scene_path = ""
	_loader = null
	_progress.value = 0
	_progress.hide()

func _update_progress() -> void:
	_tween.stop_all()
	
	_progress.max_value = _loader.get_stage_count()
	_tween.interpolate_property(
		_progress,
		"value",
		_progress.value,
		_loader.get_stage(),
		get_process_delta_time()
	)
	_tween.start()
