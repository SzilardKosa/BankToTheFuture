extends Control
signal bought

var shop_item_ui = []

func _ready():
	for _i in self.get_children():
		if _i is Control and "ShopItemUI" in _i.name  :
			shop_item_ui.append(_i)
	pass

func _on_Button_pressed():
	emit_signal("bought")
	pass # Replace with function body.


func _on_ShopItemUI_changed():
	$Label.text = str($ShopItemUI2.get_value() + $ShopItemUI.get_value() + $ShopItemUI3.get_value())	
	var value = 0
	for siu in shop_item_ui:
		value += siu.get_value()
	$Label.text = str(value);
	pass # Replace with function body.
