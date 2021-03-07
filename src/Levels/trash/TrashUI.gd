extends Control

onready var info_panel = $InfoPanel

func _ready():
	info_panel.set_deferred("visible", false)

func _on_InfoButton_pressed():
	info_panel.set_deferred("visible", true)


func _on_Exit_pressed():
	info_panel.set_deferred("visible", false)
