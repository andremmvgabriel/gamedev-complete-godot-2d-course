extends Node2D

@export var LIVES = 3
@export var SCORE = 0

@onready var ui = $UI # Same as get_node("UI")
@onready var hud = $UI/HUD # Same as get_node("UI/HUD")
@onready var player_ship = $PlayerShip # Same as get_node("PlayerShip")
@onready var enemy_spawner = $EnemySpawner # Same as get_node("EnemySpawner")

@onready var game_over_sfx = $Audio/GameOverSFX # Same as get_node("Audio/GameOverSFX")
@onready var player_hit_sfx = $Audio/PlayerHitSFX # Same as get_node("Audio/PlayerHitSFX")
@onready var player_destroyed_sfx = $Audio/PlayerDestroyedSFX # Same as get_node("Audio/PlayerDestroyedSFX")
@onready var enemy_destroyed_sfx = $Audio/EnemyDestroyedSFX # Same as get_node("Audio/EnemyDestroyedSFX")

@onready var game_over_screen_prefab = preload("res://prefabs/game_over_screen.tscn")

func _ready():
	hud.set_score_label(SCORE)
	hud.set_lives_amount(LIVES)
	player_ship.connect("player_take_damage", _on_player_take_damage)
	enemy_spawner.connect("enemy_spawned", _on_enemy_spawned)
	enemy_spawner.connect("enemy_path_spawned", _on_enemy_path_spawned)

func _on_player_take_damage():
	LIVES -= 1
	hud.remove_life()
	if LIVES <= 0:
		player_ship.die()
		_show_game_over_screen()
		player_destroyed_sfx.play()
	else:
		player_hit_sfx.play()

func _on_enemy_spawned(enemy_instance):
	enemy_instance.connect("enemy_destroyed", _on_enemy_destroyed)

func _on_enemy_path_spawned(enemy_path_instance):
	_on_enemy_spawned(enemy_path_instance.enemy)

func _on_enemy_destroyed(points):
	SCORE += points
	hud.set_score_label(SCORE)
	enemy_destroyed_sfx.play()

func _show_game_over_screen():
	await get_tree().create_timer(1).timeout
	var game_over_screen = game_over_screen_prefab.instantiate()
	ui.add_child(game_over_screen)
	game_over_screen.set_final_score(SCORE)
	game_over_sfx.play()
