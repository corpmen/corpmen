class_name Monster

extends Character

@export var monster_class: CLASSES
@export var immunity: Constants.ATTACK_TYPES
@export var zone: int


enum CLASSES {
	BUSINESS,
	TECHNICAL,
	PROJECT,
	MANAGEMENT,
	WORK,
	TASK,
}
	

func attack() -> String:

	if Game.rng.randi() % 3 == 1:
		
		if abilities.specials.size() == 0:
			return basic_attack()
		else:
			return special_attack()
			
	else:
		return basic_attack()


func basic_attack() -> String:
	
	var keys = Constants.ATTACKS.keys()
		
	var i = Game.rng.randi_range(0, keys.size() - 1)
	
	var obj = Constants.ATTACKS[keys[i]]
	
	var damage = Game.rng.randi_range(obj.min, obj.max)
	
	damage += attribute_bonus(damage, strength, Constants.ATTACK_TYPES.BASIC)
	
	damage -= attribute_bonus(damage, Game.playerData.constitution,
		Constants.ATTACK_TYPES.BASIC)
		
	Game.playerData.apply_damage(damage)

	if damage == 0:
		return "%s: %s missed" % [name, keys[i]]
	else:
		return "%s: %s for %d damage" % [name, keys[i], damage]


func special_attack() -> String:

	var damage = Constants.MIN_DAMAGE
	var length = abilities.specials.size()
	var special_name: String = ""
	
	var keys = abilities.specials.keys()
	
	if length != 0:
		
		var i = Game.rng.randi_range(0, length - 1)
		
		var obj = abilities.specials[keys[i]]
		
		special_name = keys[i]
		
		#TODO: check if key exists
		
		damage += Game.rng.randi_range(obj.min_damage, obj.max_damage)	
		
		Game.playerData.apply_damage(damage)
		
	if damage == 0:
		return "%s: %s missed" % [name, special_name]
	else:
		return "%s: %s for %d damage" % [name, special_name, damage]


func weapon_attack():
	pass
	
