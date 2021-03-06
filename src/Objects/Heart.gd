extends Area2D


onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	
	anim_player.play("bouncing")

func _on_body_entered(body: PhysicsBody2D) -> void:
	picked()


func picked() -> void:
#	PlayerData.score += score
	anim_player.play("picked")
