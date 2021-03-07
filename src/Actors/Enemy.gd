extends Actor

onready var stomp_area: Area2D = $StompArea2D
onready var player_detector = $PlayerDetector
onready var edge_detector = $EdgeDetector
onready var anim_sprite = $AnimatedSprite
onready var path: Path2D = get_node("Path2D")

signal player_hurt(this)
signal dead(this)


func _ready() -> void:
#	if path == null:
#		print("Error: nincs enemy path, ", self.name)
#	print(path.curve.get_baked_points())
	stomp_area.connect("area_entered", self, "_on_StompArea2D_area_entered")
	player_detector.connect("body_entered", self, "_on_PlayerDetector_body_entered")
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	if is_on_wall():
		change_direction()
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

	
func die() -> void:
	stomp_area.disconnect("area_entered", self, "_on_StompArea2D_area_entered")
	player_detector.disconnect("body_entered", self, "_on_PlayerDetector_body_entered")
	emit_signal("dead", self)
	anim_sprite.animation = "dead"
	_velocity.x = 0


func _on_StompArea2D_area_entered(area):
	if area.global_position.y <  stomp_area.global_position.y:
		print("died")
		die()


func _on_PlayerDetector_body_entered(body):
	emit_signal("player_hurt", self)
	print("player_died")
	pass # Replace with function body.


func _on_EdgeDetector_body_exited(body):
	print(edge_detector.get_overlapping_bodies())
	if len(edge_detector.get_overlapping_bodies()) == 1:
		print("EDGE")
		change_direction()

	
func change_direction():
	self.scale.x *= -1
	_velocity.x *= -1
#	anim_sprite.flip_h = _velocity.x < 0
#	anim_sprite.position.x = -130 if _velocity.x < 0 else 130
	pass
