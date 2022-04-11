extends KinematicBody2D

var speed = 600
var friction = 0.2
var acceleration = 0.1
var velocity = Vector2.ZERO

func _process(delta):
	var Move : Vector2
	if Input.is_action_pressed("Left"):
		Move.x = -1
		$Animations.scale.x = 1
	if Input.is_action_pressed("Right"):
		Move.x = 1
		$Animations.scale.x = -1
	Move = Move.normalized() * speed
	
	if abs(velocity.x) > 10:
		$Animations.speed_scale = abs(velocity.x) * 0.0025
		$Animations.animation = "Walk"
	else:
		$Animations.animation = "Idle"
	
	if Move.length() > 0:
		velocity = velocity.linear_interpolate(Move, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	
	print(abs(velocity.x))
	move_and_slide(velocity)
