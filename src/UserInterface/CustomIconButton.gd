extends TextureButton

export var scene_to_load: String

func _on_button_down():
	get_node("Anim").play("Pressed")


func _on_button_up():
	get_node("Anim").play("Unpressed")
