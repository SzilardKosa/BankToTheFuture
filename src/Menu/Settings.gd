tool
extends Control

onready var button_boy = get_node("MarginContainer/VBoxContainer/MarginContainer/Buttons/ButtonBoy")
onready var button_girl = get_node("MarginContainer/VBoxContainer/MarginContainer/Buttons/ButtonGirl")
onready var sprite_boy = get_node("MarginContainer/VBoxContainer/MarginContainer/Buttons/ButtonBoy/SpriteBoy")
onready var sprite_girl = get_node("MarginContainer/VBoxContainer/MarginContainer/Buttons/ButtonGirl/SpriteGirl")
onready var back = get_node("MarginContainer/VBoxContainer/Title/CustomButton")
var scene_path_to_load

export var texture_selected: Texture
export var texture_deselected: Texture

func _ready():
	button_boy.texture_normal = texture_deselected
	button_girl.texture_normal = texture_deselected
	sprite_boy.set_sprite_frames(GlobalData.frames_boy)
	sprite_girl.set_sprite_frames(GlobalData.frames_girl)
	sprite_boy.animation = "idle"
	sprite_girl.animation = "idle"
	
	if GlobalData.selected_player == GlobalData.PLAYER_BOY_ID:
		button_boy.texture_normal = texture_selected
		sprite_boy.animation = "walk"
	if GlobalData.selected_player == GlobalData.PLAYER_GIRL_ID:
		button_girl.texture_normal = texture_selected
		sprite_girl.animation = "walk"
		
	sprite_boy.play()
	sprite_girl.play()
	back.connect("pressed", self, "_on_Button_pressed", [back.scene_to_load])

func _on_Button_pressed(scene_to_load):
	$FadeIn.show()
	$FadeIn.fade_in()
	scene_path_to_load = scene_to_load


func _on_FadeIn_fade_finished():
	$FadeIn.hide()
	print(get_tree().change_scene(scene_path_to_load))


func _on_ButtonBoy_button_down():
	GlobalData.selected_player = GlobalData.PLAYER_BOY_ID
	button_girl.texture_normal = texture_deselected
	button_boy.texture_normal = texture_selected
	sprite_boy.animation = "walk"
	sprite_girl.animation = "idle"



func _on_ButtonGirl_button_down():
	GlobalData.selected_player = GlobalData.PLAYER_GIRL_ID
	button_boy.texture_normal = texture_deselected
	button_girl.texture_normal = texture_selected
	sprite_boy.animation = "idle"
	sprite_girl.animation = "walk"
