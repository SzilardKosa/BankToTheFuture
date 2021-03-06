extends Node

const PLAYER_BOY_ID = 0
const PLAYER_GIRL_ID = 1

const frames_boy: SpriteFrames = preload("res://src/Actors/BoyAnimatedShort.tres")
const frames_girl: SpriteFrames = preload("res://src/Actors/GirlAnimatedShort.tres")

const shop_item_list = [["Egg",preload("res://assets/eggs/White.png"),"Tojás"],["Milk", preload("res://assets/shop/milk.png"),"Tej"], ["Flour",preload("res://assets/shop/flour.png"),"Liszt"],["Apple",preload("res://assets/shop/apple.png"),"Alma"],["Bread",preload("res://assets/shop/bread.png"),"Kenyér"]]

var selected_player = PLAYER_BOY_ID

func _ready():
	pass # Replace with function body.
