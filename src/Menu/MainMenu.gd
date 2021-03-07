extends Control

var scene_path_to_load

onready var buttons = get_node("MarginContainer/VBoxContainer/MarginContainer/Buttons")
onready var settings_button = get_node("MarginContainer/VBoxContainer/Title/CustomButton")

func _ready():
	randomize()
	for button in buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	settings_button.connect("pressed", self, "_on_Button_pressed", [settings_button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load



func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	print(get_tree().change_scene(scene_path_to_load))
