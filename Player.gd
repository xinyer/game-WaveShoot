extends Sprite

const SPEED = 300

var velocity = Vector2()

func _ready():
	pass

func _process(delta):
	
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	print(velocity)
	
	global_position += SPEED * velocity * delta
	
