extends Path2D

@onready var path_follow = $PathFollow

var enemy

func _ready():
	path_follow.progress_ratio = 0
	if enemy:
		path_follow.add_child(enemy)
		enemy.global_position = path_follow.global_position
		enemy.SPEED = 0
	else:
		queue_free()

func _process(delta):
	path_follow.progress_ratio += 0.25 * delta
	if path_follow.progress_ratio >= 1:
		queue_free()

func set_enemy(enemy_instance):
	enemy = enemy_instance
