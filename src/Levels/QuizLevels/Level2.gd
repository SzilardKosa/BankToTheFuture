extends Node2D

onready var level_ui = $InterfaceLayer/LevelUI
onready var control = $InterfaceLayer/Control
onready var pause_menu = $InterfaceLayer/PauseMenu
onready var quiz_ui = $InterfaceLayer/QuizUI
onready var warning = $InterfaceLayer/Warning
onready var quiz_back = $InterfaceLayer/QuizBack
onready var score_menu = $InterfaceLayer/ScoreMenu
onready var player = $GameLayer/Player
onready var level_end = $GameLayer/LevelEnd
onready var doors = $GameLayer/Doors.get_children()
onready var hearts = $GameLayer/Hearts.get_children()
onready var infos = $GameLayer/Infos.get_children()
onready var enemies = $GameLayer/Enemies.get_children()
onready var messeges = $GameLayer/Messeges
onready var path = $Logic/Path2D

var player_hearts = 3 setget set_player_hearts
#var time_left = 180 setget set_time_left
var progress: = 0.0

const questions = [["Melyik ország tartja az inflációs rekordot?", "Magyarország", "Zimbabwe", "Kazahsztán", "Amerikai Egyesült Államok"],\
					["Megközelítőleg hány forintba került egy BTC 2021. márciusában?", "15 millió", "10 ezer", "350", "1"], \
					["Miért kockázatos devizahitelt felvenni?", "Nem garantált az árfolyam", "Forintban nagyobb a címlet", "A külföldi valuta nem beszél magyarul", "A többiek közül egyik sem"], \
					["Melyik hitelt nem éri meg felvenni?", "Devizahitel", "Alacsony THM-mel rendelkező", "Deviza alapú", "Diákhitel"]]
const info_texts = ["A bitcoin 2020 őszén nagy növekedésnek indult, 2021 elején egy bitcoin már több mint 10 millió magyar forintot ért.", \
					"Devizahitel két legnagyobb veszélyessége az árfolyamkockázat és a kamatkockázat.", \
					"Deviza: számlapénz a külföldi ország pénznemében.\n Valuta: készpénz a külföldi ország pénznemében.", \
					"Az infláció az árak tartós emelkedését jelenti, miközben a pénz vásárlóereje romlik. Szélsőséges nagy infláció esetben hiperinflációról beszélhetünk.", \
					"Zimbabwében hiperinflációba torkolló pénzromlás kezdődött 2008 tavaszán. Ez megközelítette, de nem érte el az 1946-os magyar rekordot.", \
					"A bitcoin egy kriptovaluta, devizakódja a BTC.", \
					"Devizahitel és deviza alapú hitel között az a lényegi különbség, hogy a devizahitel esetében a törlesztés ténylegesen devizában történik, míg deviza alapúnál forintban. Emiatt lényegesen kockázatosabb és kerülendő a devizahitel."]

var final_text = "1946. augusztus 1-jén a magyar pengőt leváltotta a forint, ekkor 400 000 000 000 000 000 000 000 000 000 (4 × 10^29) pengő ért egy forintot."

var active_door_index = -1
var enemies_killed = 0


func _ready():
#	randomize() # debug
	for door in doors:
		door.connect("door_knocked", self, "_door_knocked")
	for heart in hearts:
		heart.connect("on_picked_up", self, "_heart_picked")
	for enemy in enemies:
		enemy.connect("dead", self, "_enemy_died")
		enemy.connect("player_hurt", self, "_on_player_hurt")
	for i in range(len(infos)):
		infos[i].label.text = info_texts[i % len(info_texts)]
	set_player_hearts(player_hearts)
	
	quiz_back.set_deferred("visible", false)


func _process(delta):
	calc_set_progress()
	
func _enemy_died(enemy):
	enemies_killed += 1
	pass
	
func _on_player_hurt(enemy):
	player_hurt()
	pass

func _on_QuizBack_pressed():
	exit_quiz_mode(false)

func _door_knocked(door_name):
	for i in range(len(doors)):
		if doors[i].name == door_name:
			active_door_index = i 
	enter_quiz_mode()

func _heart_picked(body):
	if player_hearts < 5:
		self.player_hearts += 1

func _on_quiz_answered(correct):
	if correct == 1:
		yield(quiz_ui, "quiz_anim_finished")
		exit_quiz_mode(true)
	else:
		self.player_hearts -= 1


func _on_LevelEnd(body):
		level_done()

func set_player_hearts(value):
	player_hearts = value
	if player_hearts < 0:
		player_hearts = 0
	level_ui.hearts = player_hearts
	if player_hearts == 0:
		game_over()


func enter_quiz_mode():
	control.set_deferred("visible", false)
	pause_menu.set_deferred("visible", false)
	get_tree().paused = true
	quiz_ui.question_data = questions[active_door_index % len(questions)]
	quiz_ui.show()
	quiz_back.visible = true

func exit_quiz_mode(success):
	quiz_ui.hide()
	quiz_back.set_deferred("visible", false)
	control.visible = true
	pause_menu.visible = true
	get_tree().paused = false
	if success:
		doors[active_door_index].open()
	active_door_index = -1

func calc_set_progress():
	var closest_point = path.curve.get_closest_point(player.global_position)
	var offset = path.curve.get_closest_offset(closest_point)
	var length = path.curve.get_baked_length()
	print(offset/length)
#	exponenciális szűrő :D
	progress = offset/length #progress*0.95 + offset/length*0.05
	level_ui.progress = progress


func game_over():
	score_menu.show_menu("Sajnos nem sikerült :(", final_text)
	print("game over")

func level_done():
	score_menu.show_menu("Szép munka!", final_text)
	print("level done")
	
func player_hurt():
	var anim_time_left = player.get_node("InvinciblePlayer").current_animation_length - player.get_node("InvinciblePlayer").current_animation_position
	if anim_time_left < 0.1:
		player.get_node("InvinciblePlayer").play("invincible")
		self.player_hearts -= 1
		

