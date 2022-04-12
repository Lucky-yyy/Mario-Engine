extends Node2D

func _process(delta):
	$CanvasLayer/Label.text = "is_on_floor: " + str($Mario.is_on_floor())
	$CanvasLayer/Label.text += "\n" + "jumping: " + str($Mario.jumping)
	$CanvasLayer/Label.text += "\n" + "jumphold: " + str($Mario.jumphold)
	
