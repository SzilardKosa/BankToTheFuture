extends Area2D

onready var sprite = $Sprite

signal door_knocked(door_name)

func _on_body_entered(body):
	print("git commit test")
	emit_signal("door_knocked", self.name)

func open():
	sprite.animation = "open"
	self.collision_mask = 0x00
	
func close():
	sprite.animation = "close"
	self.collision_mask = 0x01
