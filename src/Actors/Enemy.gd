extends Actor

onready var stomp_area: Area2D = $StompArea2D
onready var player_detector = $PlayerDetector
onready var edge_detector = $EdgeDetector
onready var anim_sprite = $AnimatedSprite
onready var anim_player = $AnimationPlayer
onready var timer = $Timer

export var bounty: NodePath


signal player_hurt(this)
signal dead(this)


func _ready() -> void:
#	stomp_area.connect("area_entered", self, "_on_StompArea2D_area_entered")
#	player_detector.connect("body_entered", self, "_on_PlayerDetector_body_entered")
#	edge_detector.connect("body_entered", self, "_on_EdgeDetector_body_exited")
	_velocity.x = speed.x
	change_direction()
	anim_sprite.animation = "walk"
	anim_sprite.playing = true


func _physics_process(delta: float) -> void:
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if is_on_wall():
		change_direction()


func _on_StompArea2D_area_entered(area):
	if area.global_position.y <  stomp_area.global_position.y:
#		print("died")
		die()


func _on_PlayerDetector_body_entered(body):
	emit_signal("player_hurt", self)
#	print("player_died")
	pass # Replace with function body.


func _on_EdgeDetector_body_exited(body):
#	print(edge_detector.get_overlapping_bodies())
#	print(timer.time_left)
	if edge_detector.monitoring:
		if len(edge_detector.get_overlapping_bodies()) == 1:
			change_direction()

	
func change_direction():
	if timer.time_left < 0.01:
		_velocity.x *= -1
		if _velocity.x < 0:
			self.scale.x = -abs(self.scale.x)
		else:
			self.scale.x = -abs(self.scale.x)
		
	timer.start()

func die() -> void:
	stomp_area.set_deferred("monitoring", false)
	player_detector.set_deferred("monitoring", false)
	edge_detector.set_deferred("monitoring", false)
	_velocity.x = 0
	anim_sprite.animation = "dead"
	anim_player.play("die")
	emit_signal("dead", self)
	
func show_bounty():
	var b = get_node(bounty)
	if b != null:
		b.global_position = self.global_position
		b.visible = true
	print("bounty_showed")
		
	
