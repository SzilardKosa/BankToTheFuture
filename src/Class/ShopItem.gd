extends Node
class_name ShopItem
var _value
var _checked
var _name


func _init(name, value, checked):
	_name = name
	_value = value
	_checked = checked

func getValue():
	return _value
func getName():
	return _name
func getChecked():
	return _checked
func setName(name):
	_name = name
	pass
func setChecked(checked):
	_checked = checked
	pass
func setValue(value):
	_value = value
	pass
func print_test():
	print(_name + " " + str(_value) )
	pass
