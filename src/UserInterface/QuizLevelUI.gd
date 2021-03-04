extends MarginContainer

onready var time_label: Label = $HBoxContainer/Time
onready var progress_bar = $HBoxContainer/TextureProgress

var time_left = 0 setget set_time_left
var progress = 0  setget set_progress

func set_time_left(value):
	time_left = value
	if time_left < 0:
		time_left = 0
	if(time_label != null):
		time_label.text = "%02d:%02d" % [time_left/60, time_left % 60]
	
func set_progress(value):
	progress = value
	if(progress_bar != null):
		progress_bar.value = value
