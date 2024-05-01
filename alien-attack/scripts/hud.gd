extends Control

@onready var score = $Score # Same as get_node("Score")
@onready var lives = $Lives # Same as get_node("Lives")
@onready var lives_container = $LivesContainer # Same as get_node("LivesContainer")

@onready var life_icon = preload("res://resources/sprites/player/spaceShips_009.png")

func set_lives_amount(amount):
	for i in amount:
		var life_texture = TextureRect.new()
		life_texture.texture = life_icon
		life_texture.position = lives.position + Vector2(lives.size.x, 0) + Vector2(85, 0) * i
		life_texture.scale = Vector2(0.65, 0.65)
		lives_container.add_child(life_texture)

func set_score_label(points):
	score.text = "SCORE: " + str(points)

func remove_life():
	lives_container.get_children().back().queue_free()
