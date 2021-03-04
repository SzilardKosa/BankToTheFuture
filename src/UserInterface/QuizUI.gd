extends Control

# TODOs
# visszajelzés hibás/jó válaszra

signal quiz_answered(correct) # 0 - wrong answer, 1 - correct answer
signal quiz_anim_finished

onready var question = $ForPadding/Padding/VBoxContainer/Question
onready var button_path = $ForPadding/Padding/VBoxContainer/Answers

#onready var test_anim = $MarginContainer/VBoxContainer/GridContainer/Answer1/Anim

var buttons_selected = [false, false, false, false]

var question_data: = ["","","","",""] setget set_question_data
var good_answer_index = -1

func _ready():
	self.visible = false
	
func _on_button_up(extra_arg_0):
#	print("button %d is up" % extra_arg_0)
	if buttons_selected[good_answer_index]:
		return
	if buttons_selected[extra_arg_0]:
		return
	buttons_selected[extra_arg_0] = true

	if extra_arg_0 == good_answer_index:
		button_path.get_child(extra_arg_0).get_node("Anim").play("GoodAnswer")
		emit_signal("quiz_answered", 1)
	#		print("good answer")
	else:
		button_path.get_child(extra_arg_0).get_node("Anim").play("BadAnswer")
		emit_signal("quiz_answered", 0)
#		print("wrong answer")

func _on_animation_finished(anim_name):
	emit_signal("quiz_anim_finished")

func set_question_data(value):
	question_data = value
	while(len(question_data) < 5 ):
		question_data.append("")

	# apperance
	for i in range(4):
		button_path.get_child(i).get_node("Anim").play("Default")
	
	# data
	buttons_selected = [false, false, false, false]
	question.text = question_data[0]

	var indexes = range(1,5)
	indexes.shuffle()
	print(indexes)
	good_answer_index = indexes[0]
	
	for i in range(4):
		button_path.get_child(i).get_node("Label").text = question_data[indexes[i]]
		if indexes[i] == 1:
			good_answer_index = i


func show():
	self.visible = true
#	print("quiz displayed")

func hide():
	self.visible = false
#	print("quiz hided")
