extends Area2D



func _on_coin_body_entered(body):
	get_tree().call_group("player","point")
	queue_free()
