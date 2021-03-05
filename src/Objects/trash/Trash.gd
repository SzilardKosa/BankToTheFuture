extends RigidBody2D
class_name Trash

enum TRASH_TYPE {mixed, plastic, paper}
export(TRASH_TYPE) var type = TRASH_TYPE.mixed
export(String) var trash_name = "szemét"

onready var picked_up_position = get_node("../Player/TrashPosition")
onready var collision_shape = get_node("CollisionShape2D")
onready var interaction_area = get_node("InteractionArea")
onready var pickup_timer = get_node("PickUpTimer")

signal picked_up(trash)
signal dropped

var picked_up = false

func _physics_process(delta):
	if picked_up:
		self.position = picked_up_position.global_position
		sleeping = true

func _on_PickUpButton_pressed():
	if not picked_up:
		pick_up_trash()

func pick_up_trash():
	picked_up = true
	collision_shape.disabled = true
	interaction_area.visible = false
	emit_signal("picked_up", self)

func _input(event):
	if Input.is_action_just_pressed("drop") and picked_up:
		drop_trash()

func drop_trash():
	picked_up = false
	collision_shape.disabled = false
	pickup_timer.start()
	emit_signal("dropped")


func _on_PickUpTimer_timeout():
	interaction_area.visible = true
