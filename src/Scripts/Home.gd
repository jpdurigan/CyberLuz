extends Control
  


func _on_ButtonCredits_button_down():
	get_tree().change_scene_to_packed(load("res://Scenes/Credits.tscn"))
	pass # Replace with function body.



func _on_ButtonIniciar_button_down():
	SceneChanger.change_to("res://Scenes/CyberLuz.tscn")
	pass # Replace with function body.pass # Replace with function body.
