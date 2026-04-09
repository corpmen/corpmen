class_name Combat
	
	
func calculate_damage(attack_type: int, attack: String, monster: Dictionary,
  is_player_attacking: bool) -> int:

	var damage = Constants.MIN_DAMAGE
	
	var obj = Constants.ATTACKS[attack]
	#TODO: check if key exists
	
	damage += Game.rng.randi_range(obj.min, obj.max)
	
	if is_player_attacking:
		damage += Game.playerData.strength - monster.constitution
	else:
		damage += monster.strength - Game.playerData.constitution
	
	return max(1, damage)



	
