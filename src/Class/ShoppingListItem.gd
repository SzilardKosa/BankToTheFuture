extends Node
var _value
var _checked
var _number
var _current

func _init(value, checked, number, current = 0):
	_value = value
	_checked = checked
	_number = number
	_current = current

func getValue():
	return _value
func getNumber():
	return _number
func getCurrent():
	return _current
func getChecked():
	return _checked
func setChecked(checked):
	_checked = checked
	pass
func setValue(value):
	_value = value
	pass
func setCurrent(current):
	_current += current
	if(_current >= _number):
		_current = _number
		_checked = true
	pass
func setNumber(number):
	_number = number
	pass
func getRealName():
	for item in GlobalData.shop_item_list:
		if _value == item[0]:
			return item[2]
	return null


