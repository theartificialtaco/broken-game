extends Area2D

var vel = Vector2()
var speed = -7

func _physics_process(delta):
	
	vel.x = speed
	
	translate(vel)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_evil_fireball_body_entered(body):
	if body.name == "player":
		get_tree().call_group("world","death")
		get_tree().call_group("shake","high")
		queue_free()
