extends Node2D

onready var trash_drop_button = get_node("TrashInterfaceLayer/Control/Drop/DropButton")

var trash_count = 0
var current_trash: Trash

func _ready():
	for child in get_children():
		if child is Trash:
			trash_count += 1
			child.connect("picked_up", self, "_on_picked_up")
			child.connect("dropped", self, "_on_dropped")
		if child is TrashCan:
			child.connect("right_trash", self, "_on_right_trash")
			child.connect("wrong_trash", self, "_on_wrong_trash")
	print("Total number of trash: ",trash_count)
	trash_drop_button.hide()

func _on_picked_up(trash: Trash):
	print("Picked up: " + trash.trash_name)
	if current_trash != null:
		current_trash.drop_trash()
	current_trash = trash
	trash_drop_button.show()

func _on_dropped():
	print("Dropped")
	current_trash = null
	trash_drop_button.set_deferred("visible", false)

func _on_right_trash():
	print("right trash")
	trash_count -= 1
	print("Total number of trash: ",trash_count)
	if trash_count == 0:
		game_finished()

func _on_wrong_trash():
	print("wrong trash")
	print("Total number of trash: ",trash_count)

func game_finished():
	print("Finished")
	
