extends Node2D
export var starting_cash = 50000
export var shopping_list = [["Egg",5],["Milk",2]]

var shop_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for item in shopping_list:
		$InterfaceLayer/ShoppingList.Add_List(item[0], item[1])
	$InterfaceLayer/ShoppingList.SetWealth(starting_cash)
	
	for child in get_children():
		if child is Shop:
			shop_list.append(child)
			child.setWealth(starting_cash)
	pass # Replace with function body.

func _on_Shop_ShopUI(boolean):
	$InterfaceLayer/Control.visible = !boolean
	pass # Replace with function body.


func _on_Shop_Bought(value, list):
	for items in list:
		$InterfaceLayer/ShoppingList.Bought_Item(items[0],items[1]);
	starting_cash -= value
	$InterfaceLayer/ShoppingList.SetWealth(starting_cash)
	
	for child in shop_list:
		child.setWealth(starting_cash)
	pass # Replace with function body.
