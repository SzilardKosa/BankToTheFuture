extends Control

export(String) var menu_screen = ""
export(String) var next_screen = ""

onready var title_label = $MarginContainer/VBoxContainer/Title/TitleLable
onready var content_label = $MarginContainer/VBoxContainer/Title2/NinePatchRect/ContentLable
onready var next_button = $MarginContainer/VBoxContainer/MarginContainer/Buttons/NextButton
onready var right_padding = $MarginContainer/VBoxContainer/MarginContainer/Buttons/right

var scene_path_to_load

func _ready():
	set_deferred("visible", false)
	if next_screen == "":
		next_button.set_deferred("visible", false)
		right_padding.set_deferred("visible", false)

func show_menu(title: String, content: String):
	title_label.text = title
	content_label.text = content
	set_deferred("visible", true)

func _on_RestartButton_pressed():
	_change_scene("restart")

func _on_MenuButton_pressed():
	_change_scene(menu_screen)

func _on_NextButton_pressed():
	_change_scene(next_screen)

func _change_scene(new_scene:String):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = new_scene

func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	if scene_path_to_load == "restart":
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene(scene_path_to_load)




