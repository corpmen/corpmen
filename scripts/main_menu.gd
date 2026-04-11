extends CanvasLayer

func _ready() -> void:
	update_page_data()


func update_page_data() -> void:
	
	$control/tabs/Status/General/NameA.text = Game.playerData.name
	
	$control/tabs/Status/General/ClassA.text = Constants.CharacterClassNames[
		Game.playerData.player_class]
	
	$control/tabs/Status/General/HitpointsA.text = str(
		Game.playerData.hitpoints_to_string())
		
	$control/tabs/Status/General/StaminaA.text = str(
		Game.playerData.stamina_to_string())
		
	$control/tabs/Status/General/LevelA.text = str(
		Game.playerData.get_level())
		
	$control/tabs/Status/General/ExperienceA.text = str(Game.playerData.xp)
	
	$control/tabs/Status/General/CashA.text = str(Game.playerData.cash)
	
	$control/tabs/Status/Attributes/StrengthA.text = str(
		Game.playerData.strength)
		
	$control/tabs/Status/Attributes/DexterityA.text = str(
		Game.playerData.dexterity)
		
	$control/tabs/Status/Attributes/ConstitutionA.text = str(
		Game.playerData.constitution)
	
	$control/tabs/Status/Attributes/IntelligenceA.text = str(
		Game.playerData.intelligence)
		
	$control/tabs/Status/Attributes/WisdomA.text = str(
		Game.playerData.wisdom)
		
	$control/tabs/Status/Attributes/CharismaA.text = str(
		Game.playerData.charisma)
	
	$control/tabs/Status/Wellness/KarmaA.text = str(Game.playerData.karma)
	$control/tabs/Status/Wellness/SatisfactionA.text = str(
		Game.playerData.satisfaction)
	$control/tabs/Status/Wellness/StressA.text = str(Game.playerData.stress)
	$control/tabs/Status/Wellness/IntegrityA.text = str(
		Game.playerData.integrity)
	$control/tabs/Status/Wellness/PopularityA.text = str(
		Game.playerData.popularity)
	
	
func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("toggle_menu"):
		#queue_free()
		update_page_data()


#func _on_button_pressed() -> void:
#	var pos = global_position + Vector2(0, size.y)
	
	
