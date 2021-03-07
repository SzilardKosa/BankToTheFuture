extends Node

const PLAYER_BOY_ID = 0
const PLAYER_GIRL_ID = 1

const frames_boy: SpriteFrames = preload("res://src/Actors/BoyAnimatedShort.tres")
const frames_girl: SpriteFrames = preload("res://src/Actors/GirlAnimatedShort.tres")

const shop_item_list = [["Egg",preload("res://assets/eggs/White.png"),"Tojás"],["Milk", preload("res://assets/shop/milk.png"),"Tej"], ["Flour",preload("res://assets/shop/flour.png"),"Liszt"],["Apple",preload("res://assets/shop/apple.png"),"Alma"],["Bread",preload("res://assets/shop/bread.png"),"Kenyér"]]

var selected_player = PLAYER_BOY_ID

func _ready():
	pass # Replace with function body

# https://www.gyulaikozuzem.hu/adat/dokumentumtar/hu682_Erdekessegek_az_ujrahasznositasrol.pdf
const facts = [
"Tudtad-e, hogy több mint 150 millió tonna műanyag szennyezi jelenleg a világ óceánjait?",
"Tudtad-e, hogy 4,8 és 12,7 millió tonna közötti műanyag kerül az óceánokba évente?",
"Tudtad-e, hogy 1 millió tonna műanyag újrahasznosítása annyival csökkenti a szén-dioxid kibocsátást, mintha 1 millióval kevesebb autó lenne az utakon?",
"Tudtad-e, hogy az anyagok újrahasznosításának gondolata nem újdonság? Régen teljesen természetes volt, hogy amit lehetett megjavítottak, újrahasznosítottak.",
"Tudtad-e, hogy azokat a hulladékokat, amelyeket nem tudod otthon szelektíven gyűjteni, nagyrészt hulladékudvarokban térítésmentesen átveszik?",
"Tudtad-e, hogy a lejárt gyógyszerek veszélyes hulladékok, melyeket nem szabad a kukába vagy a wc-be dobni, viszont a patikákban leadhatod őket?",
"Tudtad-e, hogy ha újrahasznosítod a hulladékot, akkor nem kell költeni az ártalmatlanítására, és új nyersanyagokat sem kell környezetszennyező módon kitermelni?",
"Tudtad-e, hogy a legtöbb hulladék természetesen, környezetbarát módszerekkel is újrahasznosítható?",
"Tudtad-e, hogy Magyarországon az első szelektív hulladékgyűjtő kukákat 2003-ban helyezték ki?",
"Tudtad-e, hogy egy kis kreativitással számtalan ajándékot tudsz készíteni üvegekből, aludobozokból, vagy PET palackokból?",
"Tudtad-e, hogy Magyarországon az összegyűjtött hulladéknak csak alig több mint negyede kerül újrahasznosításra?",
"Tudtad-e, hogy a hulladék, amit kidobsz, érték? Szelektív gyűjtéssel és újrahasznosítással segíthetsz a környezet megóvásában.",
"Tudtad-e, hogy távhő és elektromos áram is lehet a kidobott karácsonyfából?",
"Tudtad-e, hogy Magyarországon az összegyűjtött hulladék 9 %-át hulladékégetőkben hasznosítják, amivel például lakótelepek fűtését oldják meg.",
"Tudtad-e, hogy egyes autók használt sütőolajjal is működnek?",
"Tudtad-e, hogy a kuka szó az 1898-ban Augsburgban alapított K.U.K.A. vállalat szemétszállító autóinak köszönhetően vált a mindennapjaink részévé?",
"Tudtad-e, hogy az újrahasznosítással készült hullámkartonokból irodabútorokat, kényelmes foteleket készítenek, melyek teherbírása akár 100 kg is lehet?"
]

func get_random_trash_fun_fact():
	return facts[randi() % facts.size()]
