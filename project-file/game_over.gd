extends Node2D
var sec = 5

func _physics_process(delta):
	get_node("Label2").set_text("Restarting in "+str(sec))
	if sec == 0:
		get_tree().change_scene("res://main.tscn")

func _on_Timer_timeout():
	sec -= 1
	$Timer.start()
