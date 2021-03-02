extends Control

# TODOs
# Multiline answers
# visszajelzés hibás/jó válaszra

signal quiz_answered(correct) # 0 - wrong answer, 1 - correct answer

onready var question = $MarginContainer/VBoxContainer/Question
onready var buttons = [$MarginContainer/VBoxContainer/GridContainer/Answer1, $MarginContainer/VBoxContainer/GridContainer/Answer2, $MarginContainer/VBoxContainer/GridContainer/Answer3, $MarginContainer/VBoxContainer/GridContainer/Answer4]
var good_answer_index = -1

export var question_text: = ""
export var good_answer_text: = ""
export var wrong_answer1_text: = ""
export var wrong_answer2_text: = ""
export var wrong_answer3_text: = ""


func _ready():
	self.visible = false
	
func _on_button_up(extra_arg_0):
#	print("button %d is up" % extra_arg_0)
	if extra_arg_0 == good_answer_index:
		emit_signal("quiz_answered", 1)
#		print("good answer")
	else:
		emit_signal("quiz_answered", 0)
#		print("wrong answer")

func shuffle():
	question.text = question_text
	
	var indexes = range(4)
	indexes.shuffle()
	good_answer_index = indexes[0]
	buttons[indexes[0]].text = good_answer_text
	buttons[indexes[1]].text = wrong_answer1_text
	buttons[indexes[2]].text = wrong_answer2_text
	buttons[indexes[3]].text = wrong_answer3_text
	

func show():
	self.visible = true
#	print("quiz displayed")
	
func hide():
	self.visible = false
#	print("quiz hided")
	



