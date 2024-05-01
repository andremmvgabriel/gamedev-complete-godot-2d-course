extends Area2D

@export var SPEED = 600.0
@export var DAMAGE = 80.0

@onready var visible_notifier = $VisibleNotifier # Same as get_node("VisibleNotifier")

func _ready():
	connect("area_entered", _on_area_entered)
	visible_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	global_position += Vector2(SPEED, 0) * delta

func _on_area_entered(area):
	queue_free()
	area.take_damage(DAMAGE)

func _on_screen_exited():
	queue_free()
