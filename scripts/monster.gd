class_name Monster

extends Character

func _init(monster_name: String):
	
	var m = Constants.MONSTERS[monster_name]
	
	name = monster_name
	
	hitpoints = m.hitpoints
	stamina = m.stamina
	strength = m.strength
	dexterity = m.dexterity
	constitution = m.constitution
	intelligence = m.intelligence
	wisdom = m.wisdom
	charisma = m.charisma
	xp = m.xp
	cash = m.cash
	
	special = m.special
	
	init_hitpoints()
	init_stamina()
	

func attack() -> String:

	if Game.rng.randi() % 2 == 1:
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
		return "missed"
	else:
		return "%s %s for %d damage" % [name, keys[i], damage]


func special_attack() -> String:

	var damage = Constants.MIN_DAMAGE
	var length = special.size()
	
	var i = randi_range(0, length - 1)
	
	var obj = Constants.SPECIAL[special[i]]
	
	#TODO: check if key exists
	
	damage += Game.rng.randi_range(obj.min, obj.max)	
	
	Game.playerData.apply_damage(damage)
	
	if damage == 0:
		return "missed"
	else:
		return "%s %s for %d damage" % [name, special[i], damage]


func weapon_attack():
	pass
	
