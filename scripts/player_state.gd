class_name PlayerState
	

static func load_player(save: String) -> PlayerData:
	
	var path = Constants.SAVE_PATH % [save]
	
	if FileAccess.file_exists(path):
		
		var tres = load(path)
				
		print(inst_to_dict(tres))
		
		return tres
	
	else:
		
		print("file not found ", error_string(FileAccess.get_open_error()))
		return null


static func update_player(save: String) -> void:
	
	var path = Constants.SAVE_PATH % [save]
	
	if Game.playerData != null:
	
		var err = ResourceSaver.save(Game.playerData, path)
		
		if err == OK:
			print("File update successful")
		else:
			print("File update failed: ", error_string(err))
	
	else:
		print("File update failed, player state null")
	


static func generate_player(c: Dictionary, name: String) -> PlayerData:
	
	var p: PlayerData = PlayerData.new()
	
	#todo: overwrite
	var path = Constants.SAVE_PATH % ["0"]
	
	p.name = name
		
	p.strength = Game.rng.randi_range(c.strength.min, c.strength.max)
	p.dexterity = Game.rng.randi_range(c.dexterity.min, c.dexterity.max)
	p.constitution = Game.rng.randi_range(c.constitution.min, c.constitution.max)
	p.intelligence = Game.rng.randi_range(c.intelligence.min, c.intelligence.max)
	p.wisdom = Game.rng.randi_range(c.wisdom.min, c.wisdom.max)
	p.charisma = Game.rng.randi_range(c.charisma.min, c.charisma.max)
	
	p.init_hitpoints()
	p.init_stamina()
	p.init_inventory()
	p.init_equipment()

	var b = load("res://items/bandage.tres").duplicate()
	var m = load("res://weapons/mouse.tres").duplicate()
	var k = load("res://weapons/keyboard.tres").duplicate()
	var e = load("res://items/energy_drink.tres").duplicate()
	
	b.quantity = 5
	e.quantity = 2

	p.inventory.add(b)
	p.inventory.add(e)
	
	p.equipment.add_weapon(m)
	p.equipment.add_weapon(k)
	
	var err = ResourceSaver.save(p, path)
	
	if err == OK:
		print("File saved successfully: ", path)
	else:
		print("Failed to save file: ", err)
	
	print(inst_to_dict(p))
	
	return p
