extends Control
#var ShopItem = load("res://src/Class/ShopItem.gd")
var Items := []
var wealth = 0
var price = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print("ALMA")
	Add_Item_Name("Egg",150)
	Add_Item_Name("Bread",200)
	draw_Item_List()
	$CanvasLayer2/PriceSum.text = str(price);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func draw_Item_List():
	$CanvasLayer2/ItemList.clear()
	draw_Label()
	for item in Items:
		$CanvasLayer2/ItemList.add_item(item.getName() + " - " + str(item.getValue()))

func draw_Label():
	$CanvasLayer2/PriceSum.text = str(price);
	
func _on_Accept_pressed():
	$CanvasLayer2/ItemList.add_item("Added",null,true)
	pass # Replace with function body.

func Add_Item(item):
	Items.append(item)
	pass
func Add_Item_Name(name, value):	
	Items.append(ShopItem.new(name, value, true))
	pass
func _on_ItemList_multi_selected(index, selected):
	print(index)
	print(selected)
	if Items.size() > index:
		price += Items[index].getValue()
		draw_Label()
	pass # Replace with function body.
