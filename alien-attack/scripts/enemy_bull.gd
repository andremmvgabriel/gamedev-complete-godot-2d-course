extends Area2D

signal enemy_destroyed(points) # This is how you create a custom signal with arguments

@export var SPEED = 600.0
@export var HEALTH = 100.0
@export var POINTS = 50

@onready var visible_notifier = $VisibleNotifier # Same as get_node("VisibleNotifier")

func _ready():
	connect("body_entered", _on_body_entered)
	visible_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	global_position -= Vector2(SPEED, 0) * delta

func _on_body_entered(body):
	body.take_damage()
	die()

func _on_screen_exited():
	queue_free()

func take_damage(damage):
	HEALTH -= damage
	if HEALTH <= 0:
		die()
		emit_signal("enemy_destroyed", POINTS) # This is how you emit the signal with arguments once something triggers it

func die():
	queue_free()
