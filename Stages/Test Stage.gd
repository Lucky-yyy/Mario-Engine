extends Node2D

func _process(delta):
	$CanvasLayer/Label.text = "x: " + str($Mario.is_on_ceiling())
