extends Area2D

func _on_win_body_entered(body):
	if body.name == "player":
		get_tree().call_group("player","next")
		get_tree().call_group("camera","win")
		queue_free()
