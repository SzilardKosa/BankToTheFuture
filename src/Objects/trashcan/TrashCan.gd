extends StaticBody2D
class_name TrashCan

enum TRASH_TYPE {mixed, plastic, paper}
export(TRASH_TYPE) var type = TRASH_TYPE.mixed

signal right_trash
signal wrong_trash

func _on_TrashDetectionArea_body_entered(body: PhysicsBody2D):
	if body is Trash:
		if type == body.type:
			emit_signal("right_trash")
			queue_free()
			body.queue_free()
		else:
			emit_signal("wrong_trash")
