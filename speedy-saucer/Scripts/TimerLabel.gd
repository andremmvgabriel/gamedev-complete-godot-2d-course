extends Label

var player_moved = false
var move_start_time = 0.0
var game_finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player_moved = false
	move_start_time = 0.0
	game_finished = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_finished:
		return
	
	if player_moved:
		var elapsed_time = Time.get_ticks_msec() - move_start_time
		
		var elapsed_time_sec = int(elapsed_time / 1000)
		var elapsed_time_msec = int((elapsed_time / 10) % 100)
		
		var elapsed_time_sec_str = "%02d" % elapsed_time_sec
		var elapsed_time_msec_str = "%02d" % elapsed_time_msec
		
		text = elapsed_time_sec_str + ":" + elapsed_time_msec_str
		return
	
	if Input.is_action_pressed("move_right"):
		player_moved = true
	
	if Input.is_action_pressed("move_left"):
		player_moved = true
	
	if Input.is_action_pressed("move_up"):
		player_moved = true
	
	if Input.is_action_pressed("move_down"):
		player_moved = true
	
	move_start_time = Time.get_ticks_msec()

func _on_area_2d_body_entered(body):
	game_finished = true
	print("1")

func _on_area_2d_body_exited(body):
	game_finished = true
	print("2")
