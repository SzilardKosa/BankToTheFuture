extends Node2D

var trash_count = 0

func _ready():
	for child in get_children():
		if child is Trash:
			trash_count += 1
		if child is TrashCan:
			child.connect("right_trash", self, "_on_right_trash")
			child.connect("wrong_trash", self, "_on_wrong_trash")
	print("Total number of trash: ",trash_count)


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
	
