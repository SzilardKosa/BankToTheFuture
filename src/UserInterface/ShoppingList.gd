extends Control

signal Done
signal Egg

var ShoppingListItem = load("res://src/Class/ShoppingListItem.gd")
var List = Array()
var Wealth = 0

onready var wealth_label = get_node("WealthLabel/Label")
onready var shopping_list_label = get_node("ShoppingListLabel/VBoxContainer/HBoxContainer/NameLabel")
onready var shopping_list_count_label = get_node("ShoppingListLabel/VBoxContainer/HBoxContainer/CountLabel")

func Add_List(text, number):
	List.append(ShoppingListItem.new(text, false, number))
	Draw_List()
	pass

func Get_List():
	$ShoppingListLabel.setSize()
	return List

func Clear_List():
	shopping_list_label.text = ""
	shopping_list_count_label.text = ""
	wealth_label.text = str(Wealth)
	pass

func Cross_Out_Item(cItem):
	for item in List:
		if item.getValue() == cItem:
			item.setChecked(true)			
	pass

func Bought_Item(name, count):
	for item in List:
		if item.getValue() == name:
			item.setCurrent(count)
	check()
	Draw_List()
	pass

func check():
	for item in List:
		if !item.getChecked():
			return
		if item.getValue() == "Egg":
			emit_signal("Egg")
	emit_signal("Done")
	pass
	

func Draw_List():
	Clear_List()
	for item in List:
		shopping_list_label.text += item.getRealName()
		shopping_list_count_label.text += str(item.getCurrent()) + " / " + str(item.getNumber()) + "\n"
		#if item.getChecked():
		#	shopping_list_label.text += " Checked"
		shopping_list_label.text += "\n"
	$ShoppingListLabel.setSize()
	pass

func SetWealth(wealth):
	print(wealth)
	Wealth = wealth
	wealth_label.text = str(Wealth)
	pass

func _ready():
	$ShoppingListLabel.setSize()
	


func _on_HBoxContainer_item_rect_changed():
	$ShoppingListLabel.setSize()
	pass # Replace with function body.

