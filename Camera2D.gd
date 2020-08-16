extends Camera2D

var screen_shake_start = false
var shake_indensity = 0

func _ready():
	Global.camera = self


func _exit_tree():
	Global.camera = null


func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	if screen_shake_start:
		global_position += Vector2(rand_range(-shake_indensity, shake_indensity), rand_range(-shake_indensity, shake_indensity)) * delta
		print(global_position)


func screen_shake(indensity, time):
	zoom = Vector2(1, 1) - Vector2(0.05, 0.05)
	shake_indensity = indensity
	$ScreenShakeTimer.wait_time = time
	$ScreenShakeTimer.start()
	screen_shake_start = true


func _on_ScreenShakeTimer_timeout():
	screen_shake_start = false
