extends CharacterBody2D

# Export variables
@export var gravity = 400 
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Constants
const SPEED = 300
const JUMP_VELOCITY = 300

# Components
@onready var sprite_animation = $SpriteAnimation

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		sprite_animation.play("run")
	
	# Gravity handling
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clampf(velocity.y, -JUMP_VELOCITY, 500)
	
	# Jump handling
	if Input.is_action_just_pressed("jump"):
		velocity.y -= JUMP_VELOCITY
	
	# Left & Right movement handling
	var x_direction = Input.get_axis("move_left", "move_right")
	velocity.x = x_direction * SPEED
	
	move_and_slide()
