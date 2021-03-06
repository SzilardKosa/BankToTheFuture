tool
extends Control
signal changed

export var price = 150
export var item_name = "Egg"

var count = 0
export var vis = false

onready var count_label = get_node("Count")
onready var price_label = get_node("Price")
onready var sprite_item = get_node("Item")
const res = preload("res://assets/shop/milk.png")

func setVis(visibly):
	vis = visibly
	pass
func _on_Add_pressed():
	count += 1
	update_label()
	pass # Replace with function body.
func _ready():
	for item in GlobalData.shop_item_list:
		if item_name == item[0]:
			sprite_item.set_texture(item[1])
	#sprite_label.texture == texture
	update_label()
	pass

func _on_Remove_pressed():
	count -= 1
	if count < 0:
		count = 0
	update_label()
	pass # Replace with function body.

func update_label():
	emit_signal("changed")
	count_label.text = str(count);
	price_label.text = str(price);
	pass

func get_value():
	return count * price

func get_count():
	return count
func get_name():
	return item_name
func set_name(name):
	item_name = name
func set_price(pr):
	price = pr
func reset():
	count = 0
	update_label()
	pass

func update():
	for item in GlobalData.shop_item_list:
		if item_name == item[0]:
			sprite_item.set_texture(item[1])
	#sprite_label.texture == texture
	update_label()
func _on_ShopItemUI_visibility_changed():
	if !vis:
		self.visible = vis
	pass # Replace with function body.
