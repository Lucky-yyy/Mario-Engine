extends KinematicBody2D

const normalspeed = 150
const runspeed = 200
const jumpstrength = 500

var friction = 0.2
const acceleration = 0.2
const gravity = 3200

func _process(delta):
	get_input(delta)
	movement(delta)

func get_input(delta):
	Move.x = 0
	if Input.is_action_pressed("Left"):
		Move.x = -1
	if Input.is_action_pressed("Right"):
		Move.x = 1
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jumping = true
	running = Input.is_action_pressed("Run")

#Movement's Variables
var velocity = Vector2.ZERO
var jumphold = 0
var jumping : bool
var running : bool
var Move : Vector2

func movement(delta):
	var speed = normalspeed
	if running and is_on_floor():
		speed = runspeed
	Move = Move.normalized() * speed
	
	if velocity.x > 0:
		$Animations.scale.x = -1
	else:
		$Animations.scale.x = 1
	
	if not is_on_floor():
		if velocity.y < 0:
			$Animations.animation = "Jump"
		elif velocity.y > 0:
			$Animations.animation = "Fall"
	elif abs(velocity.x) > 50 and not is_on_wall():
		$Animations.speed_scale = abs(velocity.x) * 0.0025
		if running and abs(velocity.x) > 145:
			friction = 0.1
			$Animations.animation = "Run"
		else:
			$Animations.animation = "Walk"
	else:
		$Animations.animation = "Idle"
	
	print("lol" + str(rand_range(-100,100)) + " " + $Animations.animation)
	
	if Move.length() > 0:
		velocity = velocity.linear_interpolate(Move, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	
	if jumping == true:
		if is_on_floor():
			velocity.y = -jumpstrength
			jumphold = 20
		if jumphold > 0 and Input.is_action_pressed("Jump"):
			jumphold -= 1
			velocity.y = -jumpstrength
		else:
			jumping = false
	else:
		jumphold = 0
	
	if not is_on_floor():
		velocity.y += delta * gravity
	
	move_and_slide(velocity, Vector2.UP)
