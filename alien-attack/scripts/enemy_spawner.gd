extends Node2D

signal enemy_spawned(enemy_instance) # This is how you create a custom signal with arguments
signal enemy_path_spawned(enemy_path_instance) # This is how you create a custom signal with arguments

@onready var enemy_bull_prefab = preload("res://prefabs/enemy_bull.tscn")
@onready var enemy_path_follow = preload("res://prefabs/enemy_path.tscn")

@onready var timer = $Timer # Same as get_node("Timer")
@onready var path_timer = $PathTimer # Same as get_node("PathTimer")
@onready var enemies_container = $EnemiesContainer # Same as get_node("EnemiesContainer")
@onready var spawner_positions = $SpawnerPositions # Same as get_node("SpawnerPositions")

func _ready():
	timer.connect("timeout", _on_timer_timeout)
	path_timer.connect("timeout", _on_path_timer_timeout)

func _on_timer_timeout():
	spawn_enemy()

func _on_path_timer_timeout():
	spawn_enemy_path()
	
func spawn_enemy():
	var list_spawner_positions = spawner_positions.get_children()
	var random_spawner_position = list_spawner_positions.pick_random()
	
	var enemy_bull = enemy_bull_prefab.instantiate()
	enemy_bull.global_position = random_spawner_position.global_position
	enemies_container.add_child(enemy_bull)
	emit_signal("enemy_spawned", enemy_bull) # This is how you emit the signal with arguments once something triggers it

func spawn_enemy_path():
	var enemy_path = enemy_path_follow.instantiate()
	var enemy_bull = enemy_bull_prefab.instantiate()
	enemy_path.set_enemy(enemy_bull)
	enemies_container.add_child(enemy_path)
	emit_signal("enemy_path_spawned", enemy_path) # This is how you emit the signal with arguments once something triggers it
