extends Node2D

onready var level_ui = $InterfaceLayer/LevelUI
onready var control = $InterfaceLayer/Control
onready var pause_menu = $InterfaceLayer/PauseMenu
onready var quiz_ui = $InterfaceLayer/QuizUI
onready var quiz_back = $InterfaceLayer/QuizBack
onready var player = $GameLayer/Player
onready var level_end = $GameLayer/LevelEnd
onready var doors = $GameLayer/Doors.get_children()
onready var hearts = $GameLayer/Hearts.get_children()
onready var infos = $GameLayer/Infos.get_children()
onready var messeges = $GameLayer/Messeges
onready var path = $Logic/Path2D

var player_hearts = 3 setget set_player_hearts
#var time_left = 180 setget set_time_left
var progress: = 0.0

const questions = [["Mi a magyar forint devizakódja?", "HUF", "EUR", "USD", "Ft"],\
					["Mikor NEM fizetünk áfát?", "Havi munkabér utalásakor", "Szupermarketből való vásárláskor", "Online ételrendeléskor", "Iskolai büfézéskor"], \
					["Egy-két-há", "Kurva anyád", "Négy-öt-hat", "Hét-Nyolc", "Kilenc"]]
const info_texts = ["Az általános forgalmi adó (áfa) egy olyan adó, melyet a  végfogyasztásra vetik ki. Azaz minden boltból vásárolt termék esetén a vásárló által fizetett ár már tartalmazza az áfát."]
var active_door_index = -1
var times_end_reached = 0


func _ready():
#	randomize() # debug
	for door in doors:
		door.connect("door_knocked", self, "_door_knocked")
	for heart in hearts:
		heart.connect("on_picked_up", self, "_heart_picked")
	for i in range(len(infos)):
		infos[i].label.text = info_texts[i % len(info_texts)]
	set_player_hearts(player_hearts)
	
	quiz_back.set_deferred("visible", false)
	level_end.position = Vector2(1856, 768)
	doors[0].set_deferred("visible", false)
	level_ui.set_deferred("visible", false)
	messeges.get_node("Label3").set_deferred("visible", false)
	messeges.get_node("Label4").set_deferred("visible", false)
	messeges.get_node("Label5").set_deferred("visible", false)
	
	if GlobalData.selected_player == GlobalData.PLAYER_BOY_ID:
		messeges.get_node("Label1").text = messeges.get_node("Label1").text % "ifjú"
	elif GlobalData.selected_player == GlobalData.PLAYER_GIRL_ID:
		messeges.get_node("Label1").text = messeges.get_node("Label1").text % "leányzó"
#	set_time_left(time_left)
#	one_sec_timer.start()


func _process(delta):
	calc_set_progress()

#func _on_OneSec_timeout():
#	self.time_left -= 1

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
	times_end_reached += 1
	if times_end_reached == 1:
		prepare_door_tutorial()
	else:
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
		if(active_door_index == 0):
			messeges.get_node("Label3").text = "Ohh persze, hát ezek kvízes pályák"
			messeges.get_node("Label4").visible = true
			messeges.get_node("Label5").visible = true
			level_ui.visible = true
			if player_hearts == 0:
				messeges.get_node("Label7").text = "Nem vagyok orvos, de a nulla szív határozottan nem egészséges. Már tárcsázom is a mentőket: 105"
				messeges.get_node("Label8").text = "Jó hírek! Gyorsan kiérkeztek és kettő szívet is tudnak neked adni. Huhh, ez necces volt. A többi pályán óvatosabban, nem lesz mindig ilyen szerencséd"
				hearts[2].position = Vector2(7552, 565.4)
			if player_hearts == 1:
				messeges.get_node("Label7").text = "Ujjujuj, egyből kettő a hibák száma, de hát minden kezdet nehéz. Még szerencse, hogy három szívvel kezdesz"
				messeges.get_node("Label8").text = "Ha nullára csökken a szíveid száma akkor sajnos újra kell kezdened a pályát. Azonban a pálya közben is találhatsz szíveket"
			if player_hearts == 2:
				messeges.get_node("Label7").text = "Egy hiba még belefér, első próbára nem is rossz. Arra vigyázz, hogy ha nullára csökken a szíveid száma, akkor újra kell kezdened a pályát"
				messeges.get_node("Label8").text = "Az elvesztett szívek pótolhatók szerencsére, csak fel kell venned őket"
			if player_hearts == 3:
				messeges.get_node("Label7").text = "Egyből hibátlan, ez már döfi! Úgy látom neked menni fognak ezek a pályák"
				messeges.get_node("Label8").text = "A pályán találhatsz extra szíveket is"
	active_door_index = -1

func calc_set_progress():
	var closest_point = path.curve.get_closest_point(player.global_position)
	var offset = path.curve.get_closest_offset(closest_point)
	var length = path.curve.get_baked_length()
#	print(offset/length)
#	exponenciális szűrő :D
	progress = progress*0.95 + offset/length*0.05
	level_ui.progress = progress


func game_over():
	print("game over")

func level_done():
	print("level done")

func prepare_door_tutorial():
	level_end.position = Vector2(17088,192)
	messeges.get_node("Label2").set_deferred("visible", false)
	messeges.get_node("Texture2").set_deferred("visible", false)
	doors[0].visible = true
	messeges.get_node("Label3").visible = true
	pass

