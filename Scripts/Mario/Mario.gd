extends KinematicBody2D

var normalspeed = 150
var runspeed = 200
var jumpstrength = 0

var friction = 0.2
var runfriction = 0.1
var acceleration = 0.2
var gravity = 600

var velocity = Vector2.ZERO
var jumping : bool
var running : bool

func _process(delta):
	var Move : Vector2
	var speed = normalspeed
	running = Input.is_action_pressed("Run")
	
	if running:
		speed = runspeed
	
	if Input.is_action_pressed("Left"):
		Move.x = -1
	if Input.is_action_pressed("Right"):
		Move.x = 1
	Move = Move.normalized() * speed
	
	if velocity.x > 0:
		$Animations.scale.x = -1
	else:
		$Animations.scale.x = 1
	
	if abs(velocity.x) > 50:
		$Animations.speed_scale = abs(velocity.x) * 0.0025
		if running and abs(velocity.x) > 190:
			friction = 0.1
			$Animations.animation = "Run"
		else:
			$Animations.animation = "Walk"
	else:
		$Animations.animation = "Idle"
	
	if Move.length() > 0:
		velocity = velocity.linear_interpolate(Move, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = -jumpstrength
	
	if not is_on_floor():
		velocity.y += delta * gravity
	
	print(abs(velocity.x))
	move_and_slide(velocity, Vector2.UP)
