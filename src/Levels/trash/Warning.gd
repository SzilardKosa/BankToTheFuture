extends Control

onready var warning_label = $NinePatchRect/Label
onready var timer = $Timer
onready var animation = $AnimationPlayer

func _ready():
	set_deferred("visible", false)

func show_warning(text: String, intervall):
	warning_label.text = text
	animation.play("fade_in")
	timer.start(intervall)

func _on_Timer_timeout():
	animation.play("fade_out")
