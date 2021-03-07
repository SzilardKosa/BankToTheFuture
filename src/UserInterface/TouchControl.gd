extends Control

func _input(_event):
	if Input.get_action_strength("move_right") == 1 :
		$LeftRight/Right/Right._on_Right_pressed()
	else:
		$LeftRight/Right/Right._on_Right_released()
	if Input.get_action_strength("move_left") == 1 :
		$LeftRight/Left/Left._on_Left_pressed()
	else:
		$LeftRight/Left/Left._on_Left_released()
	if Input.get_action_strength("jump") == 1 :
		$Jump/Jump._on_Jump_pressed()
	else:
		$Jump/Jump._on_Jump_released()
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

