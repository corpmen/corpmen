class_name PlayerData

extends Character

# main

@export var player_class: int = Constants.CharacterClasses.SWE


# wellness
@export var karma: int = 0
@export var satisfaction: int = 50
@export var stress: int = 1
@export var integrity: int = 1
@export var popularity: int = 1

@export var resurrections: int = 0


# backpack

@export var inventory: Inventory

# equipment

@export var equipment: Equipment

#var slots_max = Constants.DEFAULT_MAX_SLOTS


# storage

func test_items() -> void:
	pass
	
func get_level() -> int:
	
	var level = 1
	
	while level < Constants.MAX_LEVEL and xp >= get_xp_for_level(level + 1):
		level += 1
	
	return level
	
	
func get_xp_for_level(level: int) -> int:
	return int(100 * pow(level, Constants.FIBONACCI_MULTIPLIER))
	

func basic_attack(attack_name: String, monster: Monster) -> String:
	
	var obj = Constants.ATTACKS[attack_name]
	var damage = Constants.MIN_DAMAGE
	
	if check_stamina(obj.stamina):
		
		apply_stamina(obj.stamina)
		
		damage = randi_range(obj.min, obj.max)
	
		damage += attribute_bonus(damage, strength,
			Constants.ATTACK_TYPES.BASIC)
		
		damage -= attribute_bonus(damage, monster.constitution,
			Constants.ATTACK_TYPES.BASIC)
	
		monster.apply_damage(damage)
		
		if damage == 0:
			return "missed"
		else:
			return "%s: %s for %d damage" % [name, attack_name, damage]
		
	else:
		return "Not enough stamina to perform action %d" % [stamina]


func weapon_attack(attack_name: String, monster: Monster) -> String:
	
	var obj = Constants.WEAPONS[attack_name]
	var damage = Constants.MIN_DAMAGE
	
	damage = randi_range(obj.min, obj.max)
	
	damage -= attribute_bonus(damage, monster.constitution,
		Constants.ATTACK_TYPES.WEAPONS)
	
	monster.apply_damage(damage)
	
	if damage == 0:
		return "missed"
	else:
		return "%s: %s for %d damage" % [name, attack_name, damage]
	
	
func special_attack() -> String:
	return ""


func update_xp(gained: int) -> void:
	
	if gained > 0:
		xp += gained
		

func update_cash(gained: int) -> void:
	
	if gained > 0:
		cash += gained


func replenish_stamina() -> void:
	stamina = stamina_max


func resurrect() -> void:
	
	hitpoints = hitpoints_max
	resurrections += 1
	
	PlayerState.update_player("0")
	

func init_inventory() -> void:
	inventory = Inventory.new()
	

func init_equipment() -> void:
	equipment = Equipment.new()
