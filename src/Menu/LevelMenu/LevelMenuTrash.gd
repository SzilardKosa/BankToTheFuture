extends Control
var scene_path_to_load

onready var buttons_row1 = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Buttons")
onready var buttons_row2 = get_node("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Buttons2")
onready var label = get_node("MarginContainer/VBoxContainer/Title/TitleLable")
onready var back_button = get_node("MarginContainer/VBoxContainer/Title/CustomButton")

func _ready():
	back_button.connect("pressed", self, "_on_Button_pressed", [back_button.scene_to_load])
	for button in buttons_row1.get_children():
		if button is CustomButton:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	for button in buttons_row2.get_children():
		if button is CustomButton:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load


func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	if scene_path_to_load is String:
		print(get_tree().change_scene(scene_path_to_load))
	else:
		print(get_tree().change_scene_to(scene_path_to_load))
