extends Control

var scene_path_to_load

onready var buttons = get_node("MarginContainer/VBoxContainer/MarginContainer/Buttons")

func _ready():
	for button in buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load


func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	get_tree().change_scene_to(scene_path_to_load)
