extends Node2D


func death():
	get_tree().call_group("shake","med")
	$death_sfx.play()
	$death_explosion.play()
	get_tree().call_group("player","delete")

func _on_death_explosion_finished():
	get_tree().change_scene("res://game_over.tscn")

