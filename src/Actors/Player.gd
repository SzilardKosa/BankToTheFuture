extends Actor

onready var animated_sprite = $AnimatedSprite
onready var trash_position = $TrashPosition

export var playing = true

var can_pick = true

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	if playing:
		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
		var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
		_velocity = move_and_slide_with_snap(
			_velocity, snap, FLOOR_NORMAL, true
		)
	update_animation(direction)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity

func update_animation(direction: Vector2):
	if direction.x != 0:
		animated_sprite.flip_h = direction.x < 0
		animated_sprite.position.x = -51 if direction.x < 0 else 51
		trash_position.position.x = -86 if direction.x < 0 else 86
		
	if is_on_floor():
		animated_sprite.animation = "run" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animated_sprite.animation = "falling" if _velocity.y > 0 else "jumping"






