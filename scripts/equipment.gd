class_name Equipment

extends Resource

var weapon1: Weapon = null
var weapon2: Weapon = null

var weapons: Array[Weapon] = []
var ammo: Array[Ammunition] = []

var weapon_slot_count: int = Constants.DEFAULT_MAX_SLOTS
var ammo_slot_count: int = Constants.DEFAULT_MAX_SLOTS


func add_weapon(weapon: Weapon) -> void:
	
	var count = weapons.size()
	
	if count == weapon_slot_count:
		print("weapons full, item not added")
	else:
		weapons.append(weapon)
	

func add_ammo(new_ammo: Ammunition) -> void:
	
	var count = ammo.size()
	
	if count == ammo_slot_count:
		print("ammo full, item not added")
	else:
		ammo.append(new_ammo)
	

func get_equipped_weapons() -> Array[Item]:
	
	var equipped: Array[Item] = []
	
	if weapon1 != null:
		equipped.append(weapon1)
		
	if weapon2 != null:
		equipped.append(weapon2)
	
	return equipped


func swap_weapons() -> void:
	
	var tmp = weapon1
	
	if weapon2 != null and weapon1 != null:
		
		weapon1 = weapon2
		
		weapon2 = tmp


func equip_weapon(index: int) -> void:
	
	var count = weapons.size()
	
	if index >= count or index < 0:
		print("set weapon: index out of bounds")
		return
		
	if weapon1 == null:
		
		weapon1 = weapons[index]
		weapons.remove_at(index)
			
	elif weapon2 == null:
		
		weapon2 = weapons[index]
		weapons.remove_at(index)
	
	else:
				
		var tmp = weapon1
		
		weapon1 = weapons[index]
		
		weapons.remove_at(index)
		weapons.append(tmp)


func unset_weapon(slot: int) -> void:
	
	if slot == 0 and weapon1 != null:
		
		var tmp = weapon1
		weapon1 = null
		weapons.append(tmp)
	
	elif slot == 1 and weapon2 != null:
		
		var tmp = weapon2
		weapon2 = null
		weapons.append(tmp)
		
	else:
		print("error: unknown slot ", slot)
		
