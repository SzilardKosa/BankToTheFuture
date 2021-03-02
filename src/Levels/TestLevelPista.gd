extends Node2D

onready var control = $InterfaceLayer/Control
onready var quiz = $InterfaceLayer/QuizUI
onready var player = $Player
onready var doors = $Doors.get_children()

const questions = [["Ki ad nekem pénzt?", "AKELAAA", "Anyám", "Apám", "A farkasok"],\
					["Mennyivel megy ha háromból visszarakom kettőbe?", "620 ezer", "Vámosgyörk", "4.5", "Talán"], \
					["Egy-két-há", "Kurva anyád", "Négy-öt-hat", "Hét-Nyolc", "Kilenc"]]


var active_door_index = -1

func _ready():
	randomize()
	for door in doors:
		door.connect("door_knocked", self, "_door_knocked")
	pass
		
func _door_knocked(door_name):
	for i in range(len(doors)):
		if doors[i].name == door_name:
			active_door_index = i 
	enter_quiz_mode()
	
func _on_quiz_answered(correct):
	if correct == 1:
		exit_quiz_mode()
	
func enter_quiz_mode():
	control.visible = false
	player.playing = false
	
	var question = questions[active_door_index % len(questions)]
	quiz.question_text = question[0]
	quiz.good_answer_text = question[1]
	quiz.wrong_answer1_text = question[2]
	quiz.wrong_answer2_text = question[3]
	quiz.wrong_answer3_text = question[4]
	quiz.shuffle()
	quiz.show()

func exit_quiz_mode():
	quiz.hide()
	control.visible = true
	player.playing = true
	doors[active_door_index].open()
	active_door_index = -1

