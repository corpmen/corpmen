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
	
	if level > Constants.MAX_LEVEL:
		level = Constants.MAX_LEVEL

	return int(100 * pow(level, Constants.FIBONACCI_MULTIPLIER))
	

func xp_as_string() -> String:
	
	var needed: int = get_xp_for_level(get_level() + 1)
	
	return "%d/%d" % [xp, needed]


func is_level_up() -> bool:
	
	var actual_level = get_level()
	
	if level != actual_level:
		return true
	else:
		return false
	

func level_up() -> String:
	
	var summary: String = ""
	
	level += 1
	
	summary = "strength:\t\t%d +%d\ndexterity:\t\t%d +%d\nconstitution:\t%d +%d\nintelligence:\t%d +%d\nwisdom:\t\t\t%d +%d\ncharisma:\t\t%d +%d\n" % [strength, Constants.CharacterClassData[player_class].strength.up,\
		dexterity, Constants.CharacterClassData[player_class].dexterity.up,\
		constitution, Constants.CharacterClassData[player_class].constitution.up,\
		intelligence, Constants.CharacterClassData[player_class].intelligence.up,\
		wisdom, Constants.CharacterClassData[player_class].wisdom.up,\
		charisma, Constants.CharacterClassData[player_class].charisma.up]
		
	strength += Constants.CharacterClassData[player_class].strength.up
	dexterity += Constants.CharacterClassData[player_class].dexterity.up
	constitution += Constants.CharacterClassData[player_class].constitution.up
	intelligence += Constants.CharacterClassData[player_class].intelligence.up
	wisdom += Constants.CharacterClassData[player_class].wisdom.up
	charisma += Constants.CharacterClassData[player_class].charisma.up
	
	return summary


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
			return "%s: %s missed" % [name, attack_name]
		else:
			return "%s: %s for %d damage" % [name, attack_name, damage]
		
	else:
		return "Not enough stamina to perform action %d" % [stamina]


func weapon_attack(attack_name: String, monster: Monster) -> String:
	
	var obj = Constants.WEAPONS[attack_name]
	var damage = Constants.MIN_DAMAGE
	
	damage = randi_range(obj.min_damage, obj.max_damage)
	
	damage -= attribute_bonus(damage, monster.constitution,
		Constants.ATTACK_TYPES.WEAPONS)
	
	monster.apply_damage(damage)
	
	if damage == 0:
		return "%s: %s missed" % [name, attack_name]
	else:
		return "%s: %s for %d damage" % [name, attack_name, damage]
	
	
func special_attack(attack: SpecialAttack, monster: Monster) -> String:
	
	var damage = Game.rng.randi_range(attack.min_damage, attack.max_damage)
	
	if monster.monster_class == monster.TECHNICAL:
		damage = int(damage * attack.technical_pct/100)
	elif monster.monster_class == monster.PROJECT:
		damage = int(damage * attack.project_pct/100)
	elif monster.monster_class == monster.TASK:
		damage = int(damage * attack.task_pct/100)
	elif monster.monster_class == monster.BUSINESS:
		damage = int(damage * attack.business_pct/100)
	elif monster.monster_class == monster.MANAGEMENT:
		damage = int(damage * attack.management_pct/100)
	elif monster.monster_class == monster.WORK:
		damage = int(damage * attack.work_pct/100)
	
	if damage == 0:
		return "%s: %s missed" % [name, attack.name]
	else:
		return "%s: %s for %d damage" % [name, attack.name, damage]


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
