extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func setSize():
	self.rect_size.y = $VBoxContainer/HBoxContainer/NameLabel.rect_size[1]+30
	pass # Replace with function body.
