@tool
extends Button

var scene_path: String


func _pressed():
	SceneChanger.change_to(scene_path)


func _get(property):
	match property:
		"change_to":
			if scene_path and ResourceLoader.exists(scene_path):
				var scene = ResourceLoader.load(scene_path) as PackedScene
				return scene
		"_scene_path":
			return scene_path

func _set(property, value):
	match property:
		"change_to":
			var scene: PackedScene = value as PackedScene
			if scene:
				scene_path = scene.resource_path
		"_scene_path":
			scene_path = value

func _get_property_list() -> Array:
	var properties := []
	
	properties.append_array([
		{
			"name": "change_to",
			"type": TYPE_OBJECT,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "PackedScene",
			"usage": PROPERTY_USAGE_EDITOR,
		},
		{
			"name": "_scene_path",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_GLOBAL_FILE,
			"usage": PROPERTY_USAGE_NO_EDITOR,
		}
	])
	
	return properties
