extends Camera2D

func _process(delta):
	position = get_tree().get_current_scene().get_node("Mario").position
	position.y -= 25
	rotation_degrees += 0
	if Input.is_action_just_pressed("ui_accept"):
		zoom = Vector2(2,2)
