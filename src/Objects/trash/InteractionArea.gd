extends Area2D

onready var pickup_button = $PickUpButton


func _ready():
	pickup_button.visible = false


func _on_InteractionArea_body_entered(body):
	pickup_button.visible = true


func _on_InteractionArea_body_exited(body):
	pickup_button.visible = false
