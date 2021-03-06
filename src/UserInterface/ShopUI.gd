extends Control

signal bought(value, list)
signal exit

var shop_item_ui = []
var value = 0
var visibility = false;
var _wealth = 0

func _ready():
	for _i in $ShopLayer.get_children():
		if _i is Control and "ShopItemUI" in _i.name  :
			shop_item_ui.append(_i)
	pass

func setup(list):
	print(list)
	var i = 0
	for sui in shop_item_ui:
		sui.setVis(false)
		if i < list.size():
			if list[i] is Array and list[i].size() >= 2:
				sui.setVis(true)
				sui.set_name(list[i][0])
				sui.set_price(list[i][1])
				sui.update()
		i += 1
	pass

func _on_Button_pressed():
	var list =  []
	for shop_item in shop_item_ui:
		list.append([shop_item.get_name(),shop_item.get_count()])
	emit_signal("bought", value, list)
	pass # Replace with function body.


func _on_ShopItemUI_changed():
	value = 0
	for siu in shop_item_ui:
		value += siu.get_value()
	$ShopLayer/LabelPrice/Label.text = str(value);
	$ShopLayer/LabelWealth/Label.text = str(_wealth);
	pass # Replace with function body.


func _on_Exit_pressed():
	emit_signal("exit")
	pass # Replace with function body.

func invis(bol):
	for child in $CanvasLayer.get_children():
		child.visible = bol
	for child in $ShopLayer.get_children():
		child.visible = bol
	pass
func setWealth(wealth):
	_wealth = wealth
	pass

func _on_ShopUI_visibility_changed():
	visibility = !visibility
	invis(visibility)
	pass # Replace with function body.

func reset():
	for siu in shop_item_ui:
		siu.reset()
	pass
