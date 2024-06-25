extends KinematicBody2D

var vel = Vector2()
var gravity = 20
var maxspeed = 180
var speed = -30
var attack = false
var deceleration = false
var movement = false
var shoot = preload("res://fireball.tscn")
var stamina = 20
var firepower = 10
var point = 0
var old_controls = false

func _physics_process(delta):
	
	get_node("Control/CanvasLayer/Label4").set_text("SCORE: "+str(point))
	
	if (Input.is_action_pressed("ui_right") and old_controls == false) or (Input.is_action_pressed("old_right") and old_controls == true):
		if movement == true:
			if vel.x < maxspeed:
				vel.x += speed

	if (Input.is_action_just_released("ui_right") and old_controls == false) or (Input.is_action_just_released("old_right") and old_controls == true):
		if movement == true:
			deceleration = true

	if (Input.is_action_just_pressed("ui_up") and old_controls == false) or (Input.is_action_just_pressed("old_up") and old_controls == true):
		if movement == true and stamina > 0:
			vel.y = -400
			stamina -=1
			get_node("Control/CanvasLayer/TextureProgress").value -= 1
			$"stamina timer".start()
			$jump.play()
	
	if vel.y < 200:
		vel.y += gravity
		
	if (Input.is_action_just_pressed("ui_accept") and old_controls == false) or (Input.is_action_just_pressed("old_accept") and old_controls == true):
		if movement == true and firepower > 0:
			var fire = shoot.instance()
			get_parent().add_child(fire)
			fire.position = $Position2D.global_position
			firepower -= 1
			get_node("Control/CanvasLayer/TextureProgress2").value -= 1
			$"fire timer".start()
			$fireball.play()

	if movement == true:
		move_and_slide(vel,Vector2(0,-1))
		get_node("Control/CanvasLayer/Label").set_text("UP arrow-JUMP  Right arrow-MOVE  c-SHOOT")
		get_node("Control/CanvasLayer/Label1").set_text("W-JUMP  D-MOVE  SHIFT-SHOOT")
		$Control/CanvasLayer/Label7.hide()
	else:
		if (Input.is_action_pressed("ui_select") and old_controls == false) or (Input.is_action_pressed("old_select") and old_controls == true):
			movement = true
			get_tree().call_group("camera","move")

	if Input.is_action_just_pressed("ui_focus_next") and movement == false:
		if old_controls == true:
			old_controls = false
			$Control/CanvasLayer/Label.show()
			$Control/CanvasLayer/Label1.hide()
		else:
			old_controls = true
			$Control/CanvasLayer/Label.hide()
			$Control/CanvasLayer/Label1.show()
		print(old_controls)
		$Control/CanvasLayer/Label7.hide()

	if deceleration == true:
		if vel.x > 0:
			vel.x -= speed
		if vel.x < 0:
			vel.x += speed
		if vel.x == 0:
			deceleration = false

func _on_fire_timer_timeout():
	firepower += 1
	get_node("Control/CanvasLayer/TextureProgress2").value += 1
	if firepower < 10:
		$"fire timer".start()

func _on_stamina_timer_timeout():
	stamina += 1
	get_node("Control/CanvasLayer/TextureProgress").value += 1
	if stamina < 20:
		$"stamina timer".start()

func point():
	$coin.play()
	point -= 1
	
func delete():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	get_tree().call_group("world","death")

func next():
	movement = false
	$coin.play()
	$Control/CanvasLayer/Label.hide()
	$Control/CanvasLayer/Label2.hide()
	$Control/CanvasLayer/Label3.hide()
	$Control/CanvasLayer/TextureProgress.hide()
	$Control/CanvasLayer/TextureProgress2.hide()
	$Control/CanvasLayer/Label5.set_text("THE END")
	$Control/CanvasLayer/Label6.set_text("THANKS FOR PLAYING")
