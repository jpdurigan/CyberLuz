extends Area2D



func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CameraZoom_body_entered(body):
	if body.is_in_group("Player") and body.has_method("zoomOut"):
		body.zoomOut()


func _on_CameraZoom_body_exited(body):
	if body.name == "Player" and body.has_method("zoomIn"):
		body.zoomIn()
