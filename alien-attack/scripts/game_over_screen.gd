extends Control

@onready var score = $Panel/Score # Same as get_node("Panel/Score")
@onready var retry_button = $Panel/Retry # Same as get_node("Panel/Retry")

func _ready():
	retry_button.connect("pressed", _on_pressed)

func _on_pressed():
	get_tree().reload_current_scene()

func set_final_score(final_score):
	score.text = "SCORE: " + str(final_score)
