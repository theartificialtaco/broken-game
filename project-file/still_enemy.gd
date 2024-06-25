extends Area2D

var vel = Vector2()
var direction = 1
var coin = preload("res://coin.tscn")

func _on_still_enemy_area_entered(area):
	if area.name == "fireball":
		var point = coin.instance()
		get_parent().add_child(point)
		point.position = position
		queue_free()

func _on_still_enemy_body_entered(body):
	if body.name == "player":
		get_tree().call_group("world","death")
