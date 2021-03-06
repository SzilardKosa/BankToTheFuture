extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var anim_sprite: AnimatedSprite = $AnimatedSprite
export var score: = 100

func _ready():
	anim_sprite.playing = true
	anim_player.play("bouncing")

func _on_body_entered(body: PhysicsBody2D) -> void:
	picked()


func picked() -> void:
#	PlayerData.score += score
	anim_player.play("picked")
