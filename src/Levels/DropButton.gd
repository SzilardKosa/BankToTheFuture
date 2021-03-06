extends TouchScreenButton

func _ready():
	modulate.a = 0.5

func _input(event):
	if Input.get_action_strength("drop") == 1 :
		modulate.a = 1
	else:
		modulate.a = 0.5

