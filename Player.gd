extends Sprite

const SPEED = 300
const PLAYER_SIZE = Vector2(64, 64)

var velocity = Vector2()
var bullet = preload("res://Bullet.tscn")
var can_shoot = true
var is_dead = false

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	# Player position
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	# limit Player positon
	global_position.x = clamp(global_position.x, PLAYER_SIZE.x, get_viewport_rect().size.x - PLAYER_SIZE.x)
	global_position.y = clamp(global_position.y, PLAYER_SIZE.y, get_viewport_rect().size.y - PLAYER_SIZE.y)
	
	if not is_dead:
		global_position += SPEED * velocity * delta
	
	if Input.is_action_just_pressed("click") and Global.node_creation_parent != null and can_shoot and not is_dead:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		can_shoot = false
		$ReloadBulletTimer.start()


func _on_ReloadBulletTimer_timeout():
	can_shoot = true


func _on_HitArea_area_entered(area):
	if area.is_in_group("Enemy"):
		visible = false
		is_dead = true
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
