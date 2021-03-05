extends KinematicBody2D
class_name Shop
signal ShopUI(boolean)
signal Bought(value, list)
var wealth = 0;

func _ready():
	$ShopUI.invis(false)
	pass # Replace with function body.

func _on_ShopDoor_door_knocked():
	emit_signal("ShopUI",true)
	$ShopUI.invis(true)
	self.get_parent().get_tree().paused = true
	reset()
	pass # Replace with function body.

func setWealth(w):
	wealth = w
	pass

func _on_ShopUI_exit():
	
	emit_signal("ShopUI",false)
	$ShopUI.invis(false)
	self.get_parent().get_tree().paused = false
	pass # Replace with function body.


func _on_ShopUI_bought(value, list):
	if(value <= wealth):
		emit_signal("ShopUI",false)
		$ShopUI.invis(false)
		self.get_parent().get_tree().paused = false
		print(value)
		print(list)
		emit_signal("Bought",value, list)
	else:
		reset()
	pass # Replace with function body.

func reset():
	$ShopUI.reset()
	pass

