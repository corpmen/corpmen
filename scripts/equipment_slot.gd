class_name EquipmentSlot

extends MenuButton

signal on_weapon_equipped(index)
signal give_action_feedback(feedback)
signal drop_requested(name, index)


func _ready() -> void:
	
	var popup = get_popup()
	
	popup.id_pressed.connect(_on_menu_item_pressed)


func get_index_from_name(name: String) -> int:
	
	if name.length() == 0:
		return -1
		
	var id = name.trim_prefix("slot")
	
	return int(id)
	

func equip_weapon(index: int) -> void:
	
	var equipment = Game.playerData.equipment
	
	equipment.equip_weapon(index)

	on_weapon_equipped.emit(index)
			


func drop_equipment(index: int) -> void:
	pass


func _on_menu_item_pressed(id: int) -> void:
	
	var popup = get_popup()
	
	var action = popup.get_item_text(id)

	var index = get_index_from_name(name)
		
	match action:
		
		"Equip":

			equip_weapon(index)

		"Drop":
			
			drop_equipment(index)
			
