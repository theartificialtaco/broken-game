extends Area2D

var vel = Vector2()
var direction = 1
var coin = preload("res://coin.tscn")
var shoot = preload("res://evil_fireball.tscn")
var firestate = false

func _on_still_enemy_area_entered(area):
	if area.name == "fireball":
		var point = coin.instance()
		get_parent().add_child(point)
		point.position = position
		queue_free()

func _on_still_enemy_body_entered(body):
	if body.name == "player":
		get_tree().call_group("world","death")

func _on_timer_timeout():
	if firestate == true:
		var fire = shoot.instance()
		get_parent().add_child(fire)
		fire.position = $Position2D.global_position
		$timer.start()
		$fireball.play()

func _on_VisibilityNotifier2D_screen_entered():
		firestate = true
		$timer.start()

func _on_VisibilityNotifier2D_screen_exited():
		firestate = false
