extends Area2D
class_name Heart


onready var anim_player: AnimationPlayer = $AnimationPlayer
signal on_picked_up

func _ready():
	self.connect("body_entered", self, "_on_body_entered")
	anim_player.play("bouncing")

func _on_body_entered(body: PhysicsBody2D) -> void:
	picked()


func picked():
	emit_signal("on_picked_up", self)
	self.disconnect("body_entered", self, "_on_body_entered")
	anim_player.play("picked")
