tool
extends TextureButton
class_name CustomButton
export var texture: Texture setget _set_texture
export var label: String setget _set_label
export var scene_to_load: String

func _ready():
	_set_texture(texture)
	_set_label(label)

func _set_texture(value):
	texture = value
	if !is_inside_tree():
		return
	get_node("Texture").texture = texture

func _set_label(value):
	label = value
	if !is_inside_tree():
		return
	get_node("Texture/Label").text = label



func _on_button_down():
	get_node("Anim").play("Pressed")
	pass # Replace with function body.


func _on_button_up():
	get_node("Anim").play("Unpressed")
	pass # Replace with function body.
