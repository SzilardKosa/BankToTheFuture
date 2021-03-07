extends Node2D

export(bool) var warning_enabled = false

onready var trash_drop_button = get_node("InterfaceLayer/TrashUI/Drop/DropButton")
onready var counter_label = get_node("InterfaceLayer/TrashUI/HBoxContainer/Counter/NinePatchRect/Label")
onready var trash_label = get_node("InterfaceLayer/TrashUI/HBoxContainer/Trashlabel/NinePatchRect/TrashName")
onready var trash_ninepatch = get_node("InterfaceLayer/TrashUI/HBoxContainer/Trashlabel/NinePatchRect")
onready var warning = get_node("InterfaceLayer/TrashUI/Warning")
onready var score_screen = get_node("InterfaceLayer/ScoreMenu")

var warning_texts = ["Nem jó kukába dobtad!", "Másik típusú kukába dobd!", "Ha nem vagy biztos, hogy melyikbe tedd, akkor olvasd el a bal felső sarokban található információt!"]
var error_num = 0
var trash_count = 0
var total_num = 0
var current_trash: Trash

func _ready():
	for child in get_children():
		if child is Trash:
			trash_count += 1
			child.connect("picked_up", self, "_on_picked_up")
		if child is TrashCan:
			child.connect("right_trash", self, "_on_right_trash")
			child.connect("wrong_trash", self, "_on_wrong_trash")
	total_num = trash_count
	trash_drop_button.set_deferred("visible", false)
	update_counter()
	hide_name()

func _on_picked_up(trash: Trash):
	if current_trash != null:
		_on_dropped()
	current_trash = trash
	trash_drop_button.set_deferred("visible", true)
	show_name(trash.trash_name)

func _input(event):
	if Input.is_action_just_pressed("drop") and current_trash != null:
		_on_dropped()

func _on_dropped():
	current_trash.drop_trash()
	current_trash = null
	trash_drop_button.set_deferred("visible", false)
	hide_name()

func _on_right_trash():
	trash_count -= 1
	update_counter()
	if trash_count == 0:
		game_finished()

func _on_wrong_trash():
	if warning_enabled:
		error_num += 1
		if error_num < 2:
			warning.show_warning(warning_texts[0], 5)
		elif error_num < 3:
			warning.show_warning(warning_texts[1], 5)
		elif error_num < 5:
			warning.show_warning(warning_texts[2], 12)

func game_finished():
	score_screen.show_menu("Gratulálunk!", GlobalData.get_random_trash_fun_fact())

func update_counter():
	counter_label.text = "%d/%d" % [total_num, total_num - trash_count]

func show_name(trash_name:String):
	trash_label.text = trash_name
	trash_ninepatch.show()
	

func hide_name():
	trash_ninepatch.hide()
	
