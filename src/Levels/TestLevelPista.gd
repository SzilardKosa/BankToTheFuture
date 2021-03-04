extends Node2D

onready var level_ui = $InterfaceLayer/LevelUI
onready var control = $InterfaceLayer/Control
onready var quiz = $InterfaceLayer/QuizUI
onready var player = $GameLayer/Player
onready var doors = $GameLayer/Doors.get_children()
#onready var game = $GameLayer
onready var one_sec_timer = $Logic/OneSec
onready var path = $Logic/Path2D

export var time_left = 0 setget set_time_left
var progress: = 0.0

const questions = [["Ki ad nekem pénzt?", "AKELAAA", "Anyám", "Apám", "A farkasok"],\
					["Mennyivel megy ha háromból visszarakom kettőbe? A skoda jól megy?", "620 ezer\nMilyen skoda?", "Vámosgyörk, illetve per PVC, azaz Pécs", "4.5", "Talán"], \
					["Egy-két-há", "Kurva anyád", "Négy-öt-hat", "Hét-Nyolc", "Kilenc"]]
var active_door_index = -1


func _ready():
	randomize() # debug
	yield(get_tree().root, "ready")
	for door in doors:
		door.connect("door_knocked", self, "_door_knocked")
	pass

	set_time_left(time_left)
	one_sec_timer.start()
	

func _process(delta):
	calc_set_progress()
	
func _on_OneSec_timeout():
	self.time_left -= 1
		
func _door_knocked(door_name):
	for i in range(len(doors)):
		if doors[i].name == door_name:
			active_door_index = i 
	enter_quiz_mode()
	
func _on_quiz_answered(correct):
	if correct == 1:
		yield(quiz, "quiz_anim_finished")
		exit_quiz_mode()
	else:
		self.time_left -= 15
		
func set_time_left(value):
	time_left = value
	if time_left < 0:
		time_left = 0
	if(level_ui != null):
		level_ui.time_left = time_left
	if time_left == 0:
		game_over()

func enter_quiz_mode():
	control.visible = false
	get_tree().paused = true
	quiz.question_data = questions[active_door_index % len(questions)]
	quiz.show()

func exit_quiz_mode():
	quiz.hide()
	control.visible = true
	get_tree().paused = false
	doors[active_door_index].open()
	active_door_index = -1
	
func calc_set_progress():
	var closest_point = path.curve.get_closest_point(player.global_position)
	var offset = path.curve.get_closest_offset(closest_point)
	var length = path.curve.get_baked_length()
#	print(offset/length)
#	exponenciális szűrő :D
	progress = progress*0.95 + offset/length*0.05
	level_ui.progress = progress
	
	
func game_over():
	print("game over")




