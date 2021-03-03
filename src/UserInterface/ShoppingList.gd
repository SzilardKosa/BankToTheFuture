extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShoppingListLabel.text = "Starter List!"
	pass # Replace with function body.

func Add_List(text):
	$ShoppingListLabel.text = text
	pass
