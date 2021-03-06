extends Control

onready var pause_button = get_node("LeftTop")
onready var pause_menu = get_node("Menu")

func _ready():
	switch_to_game()

func _on_PauseButton_pressed():
	switch_to_pause()

func _on_ContinoueButton_pressed():
	switch_to_game()

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()

func _on_MenuButton_pressed():
	get_tree().change_scene("res://src/Menu/MainMenu.tscn")

func switch_to_game():
	get_tree().paused = false
	pause_button.set_deferred("visible", true)
	pause_menu.set_deferred("visible", false)

func switch_to_pause():
	get_tree().paused = true
	pause_button.set_deferred("visible", false)
	pause_menu.set_deferred("visible", true)


