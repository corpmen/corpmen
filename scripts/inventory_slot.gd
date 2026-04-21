class_name InventorySlot

extends MenuButton

signal give_action_feedback(feedback)
signal drop_requested(name, index)


@onready var label: Label = $quantity

func _ready() -> void:
	
	var popup = get_popup()
	
	popup.id_pressed.connect(_on_menu_item_pressed)
	
	
func set_quantity(count: int) -> void:
	
	if count <= 1:
		label.text = ""
	else:
		label.text = str(count)


func get_index_from_name(name: String) -> int:
	
	if name.length() == 0:
		return -1
		
	var id = name.trim_prefix("slot")
	
	return int(id)


func recover_health() -> void:
	pass


func use_item(index: int) -> void:
	
	var is_health			= false
	var is_stamina			= false
	var recovered_health 	= 0
	var recovered_stamina 	= 0
	
	var player 	= Game.playerData
	
	if index < 0 or index >= player.inventory.slot_count:
		print("index out of bounds ", index)
		return
		
	var item = player.inventory.items[index]
		
	if item.hitpoints > 0:
		
		is_health = true
		
		if player.hitpoints < player.hitpoints_max:
			
			var delta = player.hitpoints_max - player.hitpoints
			var recovered = min(item.hitpoints, delta)
		
			player.hitpoints += recovered
			
			recovered_health = recovered
			
			player.inventory.items[index].quantity -= 1
			
	if item.stamina > 0:
		
		is_stamina = true
		
		if player.stamina < player.stamina_max:
			
			var delta = player.stamina_max - player.stamina
			var recovered = min(item.stamina, delta)
			
			player.stamina += recovered
		
			recovered_stamina = recovered
				
			player.inventory.items[index].quantity -= 1
			

	if is_stamina and is_health:
		
		if recovered_health > 0 or recovered_stamina > 0:
			
			give_action_feedback.emit("Recovered %d hitpoints (%s) and %d stamina (%s)" % [\
				recovered_health, player.hitpoints_to_string(), recovered_stamina,
				player.stamina_to_string()])
				
		else:
			
			give_action_feedback.emit("Hitpoints (%s) and stamina (%s) are already full, item not used" \
				% [player.hitpoints_to_string(), player.stamina_to_string()])
			
	elif is_health:
		
		if recovered_health > 0:
		
			give_action_feedback.emit("Recovered %d hitpoints (%s)" % [\
				recovered_health, player.hitpoints_to_string()])
		
		else:
			
			give_action_feedback.emit("Hitpoints already full (%s), item not used" \
				% [player.hitpoints_to_string()])
	
	elif is_stamina:
	
		if recovered_stamina > 0:
			
			give_action_feedback.emit("Recovered %d stamina (%s)" % [\
				recovered_stamina, player.stamina_to_string()])
				
		else:
			
			give_action_feedback.emit("Stamina already full (%s), item not used" \
				% [player.stamina_to_string()])


func drop_item(index: int) -> void:
	
	var player = Game.playerData
	
	if index < 0 or index > player.inventory.items.size():
		print("error: index out of bounds for drop item")
		return
		
	var item = player.inventory.items[index]
	
	drop_requested.emit(item.name, index)


func _on_menu_item_pressed(id: int) -> void:
	
	var popup = get_popup()
	
	var action = popup.get_item_text(id)

	var index = get_index_from_name(name)
		
	match action:
		
		"Use":

			use_item(index)

		"Drop":
			
			drop_item(index)
