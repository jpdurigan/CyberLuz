tool
extends Button

export var change_to: PackedScene = null setget _set_change_to, _get_change_to
export var scene_path: String


func _ready():
	connect("pressed", self, "_on_pressed")


func _on_pressed():
	SceneChanger.change_to(scene_path)


func _set_change_to(scene: PackedScene):
	if scene:
		scene_path = scene.resource_path
		property_list_changed_notify()

func _get_change_to() -> PackedScene:
	if scene_path and ResourceLoader.exists(scene_path):
		return ResourceLoader.load(scene_path) as PackedScene
	else:
		scene_path = ""
		return null
