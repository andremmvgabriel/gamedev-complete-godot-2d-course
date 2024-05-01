extends CharacterBody2D

signal player_take_damage # This is how you create a custom signal

@export var SPEED = 18000.0

@onready var laser_prefab = preload("res://prefabs/laser.tscn")
@onready var missile_prefab = preload("res://prefabs/missile.tscn")

@onready var timer = $Timer # Same as get_node("Timer")
@onready var shots_container = $ShotsContainer # Same as get_node("ShotsContainer")

@onready var laser_sfx = $Audio/LaserSFX # Same as get_node("Audio/LaserSFX")
@onready var missile_sfx = $Audio/MissileSFX # Same as get_node("Audio/MissileSFX")

var previous_laser_shot = Time.get_ticks_msec()

func _ready():
	timer.connect("timeout", _on_timer_timeout)

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot_missile()

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * SPEED * delta
	
	var playable_size = get_viewport().content_scale_size
	global_position = global_position.clamp(Vector2(0,0), playable_size)
	
	move_and_slide()

func _on_timer_timeout():
	shoot_lasers()

func shoot_lasers():
	# Left gun
	var laser_left = laser_prefab.instantiate()
	laser_left.global_position = global_position + Vector2(60, -35)
	shots_container.add_child(laser_left)
	
	# Right gun
	var laser_right = laser_prefab.instantiate()
	laser_right.global_position = global_position + Vector2(60, 35)
	shots_container.add_child(laser_right)
	
	laser_sfx.play()

func shoot_missile():
	var missile = missile_prefab.instantiate()
	missile.global_position = global_position
	shots_container.add_child(missile)
	missile_sfx.play()

func take_damage():
	emit_signal("player_take_damage") # This is how you emit the signal once something triggers it

func die():
	queue_free()
