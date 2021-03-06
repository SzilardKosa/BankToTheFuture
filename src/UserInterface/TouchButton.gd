extends TouchScreenButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0.5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func pressedButt():
	modulate.a = 1
	pass
func releasedButt():
	modulate.a = 0.5
	pass

func _on_Left_pressed():
	modulate.a = 1
	pass # Replace with function body.


func _on_Left_released():
	modulate.a = 0.5
	pass # Replace with function body.


func _on_Jump_pressed():
	modulate.a = 1
	pass # Replace with function body.


func _on_Jump_released():
	modulate.a = 0.5
	pass # Replace with function body.


func _on_Right_pressed():
	modulate.a = 1
	pass # Replace with function body.


func _on_Right_released():
	modulate.a = 0.5
	pass # Replace with function body.
