extends HBoxContainer

@onready var _button: TextureButton = $Button
@onready var _slider: HSlider = $Slider


func _ready():
	visibility_changed.connect(_on_visibility_changed)
	_button.toggled.connect(_on_button_toggled)
	_slider.value_changed.connect(_on_slider_changed)


func _on_visibility_changed():
	_button.set_pressed_no_signal(Global.is_mute)
	_slider.value = Global.master_volume_db

func _on_button_toggled(pressed: bool):
	Global.set_audio_master_mute(pressed)

func _on_slider_changed(value: float):
	Global.set_audio_master_volume(value)
