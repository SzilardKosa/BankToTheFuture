extends Control
#var ShopItem = load("res://src/Class/ShopItem.gd")
var Items := []
# Called when the node enters the scene tree for the first time.
func _ready():
	print("ALMA")
	Add_Item_Name("Egg",150)
	draw_Item_List()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func draw_Item_List():
	$CanvasLayer2/ItemList.clear()
	for item in Items:
		$CanvasLayer2/ItemList.add_item(item.getName())

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
	if Items.size() > index:
		$CanvasLayer2/ItemList.add_item(str(Items[index].getValue()),null,true)
	pass # Replace with function body.
