extends Node2D
const testList = ["Egg", "Flour", "Bread", "Milk"]
func _ready():
	#$InterfaceLayer/Shop.Add_List("Starting List /n Is remek")
	for item in testList:
		$InterfaceLayer/Shop.Add_List(item)
	$InterfaceLayer/Shop.Cross_Out_Item("Egg")
	$InterfaceLayer/Shop.Cross_Out_Item("Bread")
	$InterfaceLayer/Shop.Draw_List()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
