extends ParallaxBackground

onready var backgrounds: = get_children()

func _ready():
	var width = get_viewport().get_visible_rect().size.x
	var height = get_viewport().get_visible_rect().size.y
	if 16.0/9.0 > width/height:
		for bg in backgrounds:
			bg.get_child(0).scale.y = 16.0/9.0 * height/width
			bg.get_child(0).scale.x = 16.0/9.0 * height/width
			bg.set_mirroring(Vector2(16.0/9.0 * height/width * 1920, 0))
