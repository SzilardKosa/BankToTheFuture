tool
extends Control
signal changed

export var price = 150
export var texture:Texture

var count = 0

onready var count_label = get_node("Count")
onready var price_label = get_node("Price")
onready var sprite_label = get_node("Item")

func _on_Add_pressed():
	count += 1
	update_label()
	pass # Replace with function body.
func _ready():
	sprite_label.texture = texture
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

