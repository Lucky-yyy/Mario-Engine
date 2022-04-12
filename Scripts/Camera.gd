extends Camera2D

func _process(delta):
	position = get_tree().get_current_scene().get_node("Mario").position
	position.y -= 25
	rotation_degrees += 0.1
