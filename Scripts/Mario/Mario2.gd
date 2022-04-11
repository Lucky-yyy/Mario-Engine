extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 300

var motion = Vector2()
func _ready():
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("Right"):
		motion.x = MAXSPEED
	elif Input.is_action_pressed("Left"):
		motion.x = -MAXSPEED
	else:
		motion.x = 0
	
	if Input.is_action_just_pressed("Jump"):
		motion.y = -JUMPFORCE
	
	motion = move_and_slide(motion,UP)
