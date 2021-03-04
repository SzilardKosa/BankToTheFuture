extends Node
var _value
var _checked

func _init(value, checked):
	_value = value
	_checked = checked

func getValue():
	return _value
func getChecked():
	return _checked
func setChecked(checked):
	_checked = checked
	pass
func setValue(value):
	_value = value
	pass

