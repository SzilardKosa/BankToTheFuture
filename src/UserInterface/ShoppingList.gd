extends Control
signal Done
var ShoppingListItem = load("res://src/Class/ShoppingListItem.gd")
var List = Array()
var Wealth = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Add_List(text, number):
	List.append(ShoppingListItem.new(text, false, number))
	Draw_List()
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

func Bought_Item(name, count):
	print(name)
	print(count)
	for item in List:
		if item.getValue() == name:
			item.setCurrent(count)
	
	Draw_List()
	pass

func check():
	for item in List:
		if !item.getChecked():
			pass
	emit_signal("Done")
	pass
	

func Draw_List():
	Clear_List()
	for item in List:
		$CanvasLayer2/ShoppingListLabel.text += item.getValue() + "  " + str(item.getNumber()) + ":" + str(item.getCurrent())
		if item.getChecked():
			$CanvasLayer2/ShoppingListLabel.text += " Checked"
		$CanvasLayer2/ShoppingListLabel.text += "\n"
	pass

func SetWealth(wealth):
	Wealth = wealth
	$CanvasLayer2/WealthLabel.text = str(Wealth)
	pass
