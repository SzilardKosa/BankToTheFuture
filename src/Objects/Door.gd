extends StaticBody2D

onready var sprite = $Sprite
onready var interaction_area = $InteractionArea
onready var collision_shape = $CollisionShape2D
onready var knock_button = $InteractionArea/KnockButton

signal door_knocked()

func _ready():
	knock_button.visible = false
	close()

func _on_InteractionArea_body_entered(body):
	knock_button.visible = true


func _on_InteractionArea_body_exited(body):
	knock_button.visible = false


func _on_KnockButton_released():
	knock_button.visible = false
	emit_signal("door_knocked", self.name)	
	
	

func open():
	sprite.animation = "open"
	collision_shape.disabled = true
	interaction_area.visible = false
#	interaction_area.collision_mask = 0x00
	
func close():
	sprite.animation = "close"
	collision_shape.disabled = false
	interaction_area.visible = true
#	self.layers = 0x02
#	interaction_area.collision_mask = 0x01
