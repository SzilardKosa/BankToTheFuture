extends Node

const PLAYER_BOY_ID = 0
const PLAYER_GIRL_ID = 1

const frames_boy: SpriteFrames = preload("res://src/Actors/BoyAnimatedShort.tres")
const frames_girl: SpriteFrames = preload("res://src/Actors/GirlAnimatedShort.tres")

var selected_player = PLAYER_BOY_ID

func _ready():
	pass # Replace with function body.
