extends Sprite

const SPEED = 50

var velocity = Vector2()
var hit = false
var hp = 3


func _process(delta):
	if Global.player != null && not hit:
		velocity = global_position.direction_to(Global.player.position)
	elif hit:
		velocity = lerp(velocity, Vector2(0, 0), 0.1)	
	
	global_position += velocity * SPEED * delta
	
	if hp == 0:
		queue_free()


func _on_HitBox_area_entered(area):
	if area.is_in_group("Enemy_damager"):
		modulate = Color.white
		hit = true
		velocity *= -4
		hp -= 1
		$HitTimer.start()


func _on_HitTimer_timeout():
	modulate = Color("#ff00db")
	hit = false
