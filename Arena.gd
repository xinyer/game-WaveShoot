extends Node2D

const RANGE = 100

var enemy = preload("res://Enemy.tscn")
var window_size

func _ready():
	Global.node_creation_parent = self
	window_size = get_viewport_rect().size
	pass


func _exit_tree():
	Global.node_creation_parent = null


func _on_EnemySpawnTimer_timeout():
	var enemy_postion = Vector2(rand_range(-RANGE, window_size.x + RANGE), rand_range(-RANGE, window_size.y + RANGE))
	# create enemy positon again if position in viewport
	while enemy_postion.x > 0 and enemy_postion.x < window_size.x and enemy_postion.y > 0 and enemy_postion.y < window_size.y:
		enemy_postion = Vector2(rand_range(-RANGE, window_size.x + RANGE), rand_range(-RANGE, window_size.y + RANGE))
	
	Global.instance_node(enemy, enemy_postion, self)
