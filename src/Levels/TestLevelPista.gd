extends Node2D

onready var level_ui = $InterfaceLayer/LevelUI
onready var control = $InterfaceLayer/Control
onready var pause_menu = $InterfaceLayer/PauseMenu
onready var quiz = $InterfaceLayer/QuizUI
onready var player = $GameLayer/Player
onready var doors = $GameLayer/Doors.get_children()
onready var hearts = $GameLayer/Hearts.get_children()
onready var infos = $GameLayer/Infos.get_children()
onready var path = $Logic/Path2D

var player_hearts = 3 setget set_player_hearts
var progress: = 0.0

const questions = [["Ki ad nekem pénzt?", "AKELAAA", "Anyám", "Apám", "A farkasok"],\
					["Mennyivel megy ha háromból visszarakom kettőbe? A skoda jól megy?", "620 ezer\nMilyen skoda?", "Vámosgyörk, illetve per PVC, azaz Pécs", "4.5", "Talán"], \
					["Egy-két-há", "Kurva anyád", "Négy-öt-hat", "Hét-Nyolc", "Kilenc"]]
const info_texts = ["Ha hitelt veszel fel, akkor nem veheted el a magyarok munkáit\nItt egy sortörés :D"]
var active_door_index = -1


func _ready():
#	randomize() # debug
	for door in doors:
		door.connect("door_knocked", self, "_door_knocked")
	for heart in hearts:
		heart.connect("on_picked_up", self, "_heart_picked")
	for i in range(len(infos)):
		infos[i].label.text = info_texts[i % len(info_texts)]
	set_player_hearts(player_hearts)
	

func _process(delta):
	calc_set_progress()
		
func _door_knocked(door_name):
	for i in range(len(doors)):
		if doors[i].name == door_name:
			active_door_index = i 
	enter_quiz_mode()
	
func _heart_picked(body):
	if player_hearts < 5:
		self.player_hearts += 1
	
func _on_quiz_answered(correct):
	if correct == 1:
		yield(quiz, "quiz_anim_finished")
		exit_quiz_mode()
	else:
		self.player_hearts -= 1
		
func _on_LevelEnd(body):
	level_done()
		
func set_player_hearts(value):
	player_hearts = value
	if player_hearts < 0:
		player_hearts = 0
	level_ui.hearts = player_hearts
	if player_hearts == 0:
		game_over()
	

func enter_quiz_mode():
	control.set_deferred("visible", false)
	pause_menu.set_deferred("visible", false)
	get_tree().paused = true
	quiz.question_data = questions[active_door_index % len(questions)]
	quiz.show()

func exit_quiz_mode():
	quiz.hide()
	control.visible = true
	pause_menu.visible = true
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
	
func level_done():
	print("level done")







