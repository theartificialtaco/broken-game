extends Node2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0

onready var camera = get_parent()

func low(duration = 0.05, frequency = 20, amplitude = 8, priority = 0):
	if priority>=self.priority:
		self.priority = priority
		self.amplitude = amplitude
		 
		$duration.wait_time = duration
		$frequency.wait_time = 1 / float(frequency)
		$duration.start()
		$frequency.start()
		
		_newShake()
	
func med(duration = 0.1, frequency = 25, amplitude = 12, priority = 0):
	if priority>=self.priority:
		self.priority = priority
		self.amplitude = amplitude
		 
		$duration.wait_time = duration
		$frequency.wait_time = 1 / float(frequency)
		$duration.start()
		$frequency.start()
		
		_newShake()
		
func high(duration = 0.1, frequency = 30, amplitude = 16, priority = 0):
	if priority>=self.priority:
		self.priority = priority
		self.amplitude = amplitude
		 
		$duration.wait_time = duration
		$frequency.wait_time = 1 / float(frequency)
		$duration.start()
		$frequency.start()
		
		_newShake()

func _newShake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude , amplitude)
	rand.y = rand_range(-amplitude , amplitude)
	
	$shakeTween.interpolate_property(camera, "offset", camera.offset, rand, $frequency.wait_time, TRANS, EASE)
	$shakeTween.start()
	
func _reset():
	$shakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $frequency.wait_time, TRANS, EASE)
	$shakeTween.start()
	
	priority = 0
	
func _on_frequency_timeout():
	_newShake()


func _on_duration_timeout():
	_reset()
	$frequency.stop()
