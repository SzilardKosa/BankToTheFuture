extends KinematicBody2D
class_name Shop
signal ShopUI(boolean)
signal Bought(value, list)
var wealth = 0;

export var list = [["Egg",150],["Milk",200]]


func _ready():
	$ShopUI.invis(false)
	$ShopUI.setup(list)
	pass # Replace with function body.

func _on_ShopDoor_door_knocked(_name):
	emit_signal("ShopUI",true)
	$ShopUI.invis(true)
	self.get_parent().get_tree().paused = true
	reset()
	pass # Replace with function body.

func setWealth(w):
	wealth = w
	$ShopUI.setWealth(w)
	pass

func _on_ShopUI_exit():
	
	emit_signal("ShopUI",false)
	$ShopUI.invis(false)
	$ShopDoor.knock()
	self.get_parent().get_tree().paused = false
	pass # Replace with function body.


func _on_ShopUI_bought(value, temp_list):
	if(value <= wealth):
		emit_signal("ShopUI",false)
		$ShopUI.invis(false)
		self.get_parent().get_tree().paused = false
		emit_signal("Bought",value, temp_list)
		
		$ShopDoor.knock()
	else:
		reset()
	pass # Replace with function body.

func reset():
	$ShopUI.reset()
	pass



func _on_ShopDoor_door_knocked2(_name):
	emit_signal("ShopUI",true)
	$ShopUI.invis(true)
	self.get_parent().get_tree().paused = true
	reset()
	pass # Replace with function body.
