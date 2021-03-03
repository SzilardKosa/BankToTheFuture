extends RigidBody2D

onready var picked_up_position = get_node("../Player/TrashPosition")
onready var player = get_node("../Player")
onready var collision_shape = get_node("CollisionShape2D")
onready var interaction_area = get_node("InteractionArea")

var picked_up = false

func _physics_process(delta):
	if picked_up:
		self.position = picked_up_position.global_position
		sleeping = true

func _on_PickUpButton_pressed():
	if not picked_up and player.can_pick:
		player.can_pick = false
		picked_up = true
		sleeping = true
		collision_shape.disabled = true
		interaction_area.visible = false

func _input(event):
	if Input.is_action_just_pressed("drop") and picked_up:
		player.can_pick = true
		picked_up = false
		sleeping = false
		collision_shape.disabled = false
		interaction_area.visible = true

