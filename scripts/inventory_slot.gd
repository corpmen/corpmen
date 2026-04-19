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


func use_item(index: int) -> void:
	
	var player 	= Game.playerData
	
	if index < 0 or index >= player.inventory.slot_count:
		print("index out of bounds ", index)
		return
		
	var item = player.inventory.items[index]
		
	if item.hitpoints > 0:
		
		if player.hitpoints < player.hitpoints_max:
			
			var delta = player.hitpoints_max - player.hitpoints
			var recovered = min(item.hitpoints, delta)
		
			player.hitpoints += recovered
			
			give_action_feedback.emit("Recovered %d hitpoints: %s" % [\
			  recovered, player.hitpoints_to_string()])
		
		else:
			
			give_action_feedback.emit("Health already full (%s), item not used" \
				% [player.hitpoints_to_string()])
			
	if item.stamina > 0:
		
		if player.stamina < player.stamina_max:
			
			var delta = player.stamina_max - player.stamina
			var recovered = min(item.stamina, delta)
			
			player.stamina += recovered
			
			give_action_feedback.emit("Recovered %d stamina, (%s)" % [\
			  recovered, player.stamina_to_string()])
			
		else:
			
			give_action_feedback.emit("Stamina already full %s, item not used" \
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
