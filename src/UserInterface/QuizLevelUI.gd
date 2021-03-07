extends MarginContainer

onready var time_label: Label = $HBoxContainer/Time
onready var progress_bar = $HBoxContainer/ForPadding/Padding/TextureProgress
onready var hearts_texture = $HBoxContainer/Control/Hearts.get_children()

var time_left = 0 setget set_time_left
var progress = 0  setget set_progress
var hearts = 0 setget set_hearts


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
		
func set_hearts(value):
	hearts = value
	if hearts < 0:
		hearts = 0
	if hearts > len(hearts_texture):
		hearts = len(hearts_texture)
	for i in range(hearts):
		hearts_texture[i].self_modulate = Color(1,1,1,1)
	for i in range(hearts, len(hearts_texture)):
		hearts_texture[i].self_modulate = Color(0.5,0.5,0.5,0.5)

	
