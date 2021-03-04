extends Control
var ShoppingListItem = load("res://src/Class/ShoppingListItem.gd")
var List = Array()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Add_List(text):
	List.append(ShoppingListItem.new(text, false))
	pass

func Get_List():
	return List

func Clear_List():
	$CanvasLayer2/ShoppingListLabel.text = ""
	pass

func Cross_Out_Item(cItem):
	for item in List:
		if item.getValue() == cItem:
			item.setChecked(true)			
	pass

func Draw_List():
	Clear_List()
	for item in List:
		$CanvasLayer2/ShoppingListLabel.text += item.getValue()
		if item.getChecked():
			$CanvasLayer2/ShoppingListLabel.text += " Checked"
		$CanvasLayer2/ShoppingListLabel.text += "\n"

	pass
