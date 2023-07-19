extends CanvasLayer

var _tween: Tween = null
var _scene_path: String = ""
var _progress: Array = []

@onready var _progress_bar: ProgressBar = $Control/ProgressBar


func _ready():
	set_process(false)
	_progress_bar.value = 0
	_progress_bar.hide()

func _process(_delta):
	var status := ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	printt(_scene_path, _progress)
	match status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, \
		ResourceLoader.THREAD_LOAD_FAILED:
			_on_load_failed()
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var progress : float = _progress[0]
			_update_progress(progress)
		ResourceLoader.THREAD_LOAD_LOADED:
			var progress : float = _progress[0]
			_update_progress(progress)
			_on_load_success()


func change_to(scene_path: String) -> void:
	_scene_path = scene_path
	ResourceLoader.load_threaded_request(scene_path, "PackedScene")
	
	_progress_bar.value = 0.0
	_progress_bar.max_value = 1.0
	_progress_bar.show()
	set_process(true)


func _on_load_success() -> void:
	var next_scene: PackedScene = ResourceLoader.load_threaded_get(_scene_path)
	get_tree().change_scene_to_packed(next_scene)
	_scene_path = ""
	
	_progress_bar.value = 0
	_progress_bar.hide()
	set_process(false)

func _on_load_failed() -> void:
	push_error(
		"Algo deu errado ao carregar a cena: %s | Progress: %s"
		% [_scene_path, _progress]
	)
	set_process(false)

func _update_progress(progress: float) -> void:
	if _tween != null:
		_tween.kill()
	_tween = create_tween()
	
	_tween.tween_property(_progress_bar, "value", progress, get_process_delta_time())
	_tween.play()
