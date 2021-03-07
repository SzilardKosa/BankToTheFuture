extends Node2D
export var starting_cash = 3000
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
	$InterfaceLayer/PauseMenu.visible = !boolean
	$InterfaceLayer/ShoppingList.visible = !boolean
	pass # Replace with function body.


func _on_Shop_Bought(value, list):
	starting_cash -= value
	$InterfaceLayer/ShoppingList.SetWealth(starting_cash)
	
	for child in shop_list:
		child.setWealth(starting_cash)
		
	for items in list:
		$InterfaceLayer/ShoppingList.Bought_Item(items[0],items[1])
	pass # Replace with function body.



func _on_ShoppingList_Done():
	$InterfaceLayer/ScoreMenu.show_menu("Gratulálunk!", "Pontszám : " + str(starting_cash))
	pass # Replace with function body.

func _on_Enemy_player_hurt(this):
	starting_cash = starting_cash - 500
	$InterfaceLayer/ShoppingList.SetWealth(starting_cash)
	this.Done()
	pass # Replace with function body.


func _on_Ninja_player_hurt(this):
	starting_cash = starting_cash - 500
	$InterfaceLayer/ShoppingList.SetWealth(starting_cash)
	
	for child in shop_list:
		child.setWealth(starting_cash)
	this.Done()
	pass # Replace with function body.
