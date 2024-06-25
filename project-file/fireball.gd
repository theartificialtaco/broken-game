extends Area2D

var vel = Vector2()
var speed = 7

func _physics_process(delta):
	
	vel.x = speed
	
	translate(vel)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_fireball_area_entered(area):
	if area.name != "player_enter":
		get_tree().call_group("shake","high")
		queue_free()
