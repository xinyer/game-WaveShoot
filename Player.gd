extends Sprite

const SPEED = 300

var velocity = Vector2()
var bullet = preload("res://Bullet.tscn")
var can_shoot = true

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	# Player position
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	global_position += SPEED * velocity * delta
	
	if Input.is_action_just_pressed("click") and Global.node_creation_parent != null and can_shoot:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		can_shoot = false
		$ReloadBulletTimer.start()


func _on_ReloadBulletTimer_timeout():
	can_shoot = true
