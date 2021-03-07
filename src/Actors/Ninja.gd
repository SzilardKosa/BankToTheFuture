extends Actor

onready var stomp_area: Area2D = $StompArea2D
onready var player_detector = $PlayerDetector
onready var anim_sprite = $AnimatedSprite
#onready var path: Path2D = get_node("Path2D")
var _active = true

signal player_hurt(this)
signal dead(this)


func _ready() -> void:
	$AnimatedSprite/AnimationPlayer.play("show")
	$AnimatedSprite.animation = "run"
	#if path == null:
	#	print("Error: nincs enemy path, ", self.name)
	#print(path.curve.get_baked_points())
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	_velocity.x *= -1 if is_on_wall() else 1
	anim_sprite.flip_h = _velocity.x < 0
	anim_sprite.position.x = -130 if _velocity.x < 0 else 130
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

	
func die() -> void:
	stomp_area.disconnect("area_entered", self, "_on_StompArea2D_area_entered")
	player_detector.disconnect("body_entered", self, "_on_PlayerDetector_body_entered")
	emit_signal("dead", self)
	anim_sprite.animation = "dead"
	_velocity.x = 0


func _on_PlayerDetector_body_entered(body):
	if _active:
		emit_signal("player_hurt", self)
	print("player_died")
	pass # Replace with function body.

func Done():
	speed = Vector2(0,0)
	_velocity.x = speed.x
	$AnimatedSprite.animation = "idle"
	$AnimatedSprite/AnimationPlayer.play("FadeIn")
	_active = false
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeIn":
		self.queue_free()
	pass # Replace with function body.
