extends Area2D

onready var anim_player = $AnimationPlayer
onready var label = $Label
export var text: String setget set_text

func _ready():
	label.set_deferred("visible", false)
	label.self_modulate = Color(1,1,1,0)
	self.connect("body_entered", self, "_on_Info_body_entered")
	self.connect("body_exited", self, "_on_Info_body_exited")



func _on_Info_body_entered(body):
	if label.self_modulate != Color(1,1,1,1):
		anim_player.play("show")
	else:
		anim_player.play("on")


func _on_Info_body_exited(body):
	anim_player.play("hide")
	
func set_text(value):
	text = value
	get_node("Label").text = text
