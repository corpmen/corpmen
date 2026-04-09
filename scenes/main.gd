extends Node2D

const CharacterMenu = preload("res://scenes/main_menu.tscn")

var main_menu = null
var is_battle = false


func _ready():
	
	Game.create_player("testplayer")
	
	if main_menu == null:
		main_menu = CharacterMenu.instantiate()
		#get_tree().root.add_child(main_menu)
		add_child(main_menu)
		main_menu.hide()


func _input(event: InputEvent) -> void:
	
	#if is_battle:
	#	return
	if event.is_action_pressed("toggle_menu"):
		
		if main_menu.visible:
			main_menu.hide()
		else:
			main_menu.show()
	#elif event.is_action_pressed("ui_cancel"):
		#main_menu.hide()
