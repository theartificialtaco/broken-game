extends Camera2D

var vel = Vector2()
var speed = 1
var move = false

func _physics_process(delta):
	
	if position.x == 3504:
		move = false

	if move == true:
		vel.x = speed
		translate(vel)

func death():
	speed = 0

func move():
	move = false
