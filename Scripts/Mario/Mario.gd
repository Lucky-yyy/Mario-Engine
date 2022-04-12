extends KinematicBody2D

const normalspeed = 175
const runspeed = 350
var inairspeed = 300
const jumpstrength = 400

var friction = 10
var acceleration = 10
const gravity = 2000

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
		inairspeed = speed
		jumping = true
	running = Input.is_action_pressed("Run")

#Movement's Variables
var velocity = Vector2.ZERO
var jumphold = 0
var jumping : bool
var running : bool
var Move : Vector2
var falling = 0
var runmeter = 0
var speed = 0

func movement(delta):
	speed = normalspeed
	friction = 10
	acceleration = 10
	if running and is_on_floor():
		friction = 10
		speed = runspeed
	
	if velocity.x > 0:
		$Animations.scale.x = -1
	if velocity.x < 0:
		$Animations.scale.x = 1
	
	if not is_on_floor():
		friction = 5
		acceleration = 5
		speed = inairspeed
		if velocity.y < 0:
			$Animations.animation = "Jump"
		elif velocity.y > 0:
			$Animations.animation = "Fall"
	elif abs(velocity.x) > 50 and not is_on_wall():
		$Animations.speed_scale = abs(velocity.x) * 0.0025
		if running and abs(velocity.x) > 145:
			friction = 5
			acceleration = 2
		else:
			friction = 10
		if abs(velocity.x) > 380:
			$Animations.animation = "Run"
		else:
			$Animations.animation = "Walk"
	else:
		$Animations.animation = "Idle"
	
	Move = Move.normalized() * speed
	
	if not Move.x == 0:
		velocity.x = lerp(velocity.x, Move.x, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta)
	
	if not is_on_floor():
		if velocity.y < 500:
			velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if jumping == true:
		if is_on_floor():
			velocity.y = -jumpstrength
			jumphold = 40
		if jumphold > 0 and Input.is_action_pressed("Jump"):
			jumphold -= 1
			velocity.y = -jumpstrength / 1.25
		else:
			jumping = false
	else:
		jumphold = 0
	
	if is_on_ceiling():
		jumping = false
		velocity.y = 10
	
	if is_on_wall():
		velocity.x = 0
	
	move_and_slide(velocity, Vector2.UP)
