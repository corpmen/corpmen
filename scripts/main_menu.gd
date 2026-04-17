extends CanvasLayer

const slot = preload("res://scenes/inventory_slot.tscn")
const empty = preload("res://assets/items/empty-item.png")

var drop_index = -1

@onready var tabs = %tabs

func _ready() -> void:
	
	#var p = %slot0.get_popup()
	$control/Feedback.visible = false
	
	$control/DropConfirm.confirmed.connect(_on_drop_confirmed)
	$control/DropConfirm.canceled.connect(_on_drop_canceled)
	
	update_status()
	
	create_inventory()


func create_inventory() -> void:
	
	var count = Game.playerData.items.size()
	
	var grid = $control/tabs/Inventory/GridContainer
		
	for child in grid.get_children():
		child.queue_free()
		
	for i in range(Game.playerData.inventory.slot_count):
		
		var s = slot.instantiate()
		
		grid.add_child(s)
		
		s.name = "slot" + str(i)
		
		s.give_action_feedback.connect(_on_inventory_notification)
		s.drop_requested.connect(_on_drop_notification)


func update_status() -> void:
	
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
	

func update_inventory() -> void:
	
	var count = Game.playerData.inventory.items.size()
	var grid = $control/tabs/Inventory/GridContainer
	
	#todo if the count is greater than size
	
	var slots = grid.get_children()
	var slot_count = slots.size()
	
	for i in range(slot_count):
		
		if i < count:
				
			slots[i].icon = load(
				Constants.ITEMS[Game.playerData.inventory.items[i].name].texture)
			
			if Game.playerData.inventory.items[i].stackable:
				slots[i].set_quantity(Game.playerData.inventory.items[i].quantity)
			else:
				slots[i].set_quantity(1)
			
			var popup = slots[i].get_popup()
			
			if Game.playerData.inventory.items[i].type == Constants.ITEM_TYPE.WEAPON:
			
				#todo: disable if equipped already

				popup.set_item_disabled(0, true) # don't hardcode
				#popup.set_item_disabled(1, true) # don't hardcode
					
			elif Game.playerData.inventory.items[i].type == Constants.ITEM_TYPE.MEDICAL or \
				  Game.playerData.inventory.items[i].type != Constants.ITEM_TYPE.EDIBLE:
					
				popup.set_item_disabled(1, true)
					
				
			
				
		else:
			
			slots[i].icon = empty
			
			slots[i].set_quantity(1)
			


func show_feedback(feedback: String) -> void:
	
	var label = $control/Feedback
	
	label.text = feedback
	
	label.modulate.a = 1.0
	
	label.show()
	
	var tween = get_tree().create_tween()
	tween.tween_interval(1.5)
	tween.tween_property(label, "modulate:a", 0.0, 0.5)
	tween.tween_callback(label.hide)
	

func show_dialog(name: String, index: int) -> void:
	$control/DropConfirm.popup_centered()
	
func _on_inventory_notification(msg: String) -> void:
	
	show_feedback(msg)


func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("toggle_menu"):
		#queue_free()
		
		var sel = tabs.current_tab
		print("tab: ", sel)
		if sel == 0:
			update_status()
		if sel == 2:
			update_inventory()


func _on_drop_confirmed() -> void:
	
	if drop_index > -1 and drop_index <= Game.playerData.inventory.items.size():
		
		Game.playerData.inventory.drop(drop_index, \
		  Game.playerData.inventory.items[drop_index].quantity)
		
		#var s = $control/tabs/Inventory/GridContainer.get_node("slot" + str(drop_index))
		update_inventory()
		
	
	else:
		print("error: invalid item index to drop ", drop_index)
		

func _on_drop_canceled() -> void:
	pass


func _on_tabs_tab_changed(tab: int) -> void:
	
	print("tabs: ", tab)
	
	match tab:
		0:
			update_status()
		1:
			update_inventory()


func _on_popup_menu_id_pressed(id: int) -> void:
	
	print("bass: ", id)	


func _on_drop_notification(name: String, index: int) -> void:
	
	drop_index = index
	
	show_dialog(name, index)
