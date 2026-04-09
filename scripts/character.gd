class_name Character

extends Resource

# main
@export var name: String = ""
@export var hitpoints_max: int = 1
@export var stamina_max: int = 1
@export var stamina: int
@export var hitpoints: int
@export var xp: int = 0
@export var cash: int = 100
@export var hitpoints_regeneration_rate: int = 0
@export var stamina_regeneration_rate: int = 0

# attributes
@export var strength: int = Constants.MIN_ATTRIBUTE
@export var dexterity: int = Constants.MIN_ATTRIBUTE
@export var constitution: int = Constants.MIN_ATTRIBUTE
@export var intelligence: int = Constants.MIN_ATTRIBUTE
@export var wisdom: int = Constants.MIN_ATTRIBUTE
@export var charisma: int = Constants.MIN_ATTRIBUTE

# special

@export var special: Array = []

# items

@export var items: Array = []

# equipped weapons

@export var weapons: Dictionary = {}

# equipped armor

@export var armor: Dictionary = {}


func init_hitpoints() -> int:
	
	hitpoints_max = Constants.BASE_HITPOINTS + int(constitution * 0.2)
	hitpoints = hitpoints_max
	
	hitpoints_regeneration_rate = Constants.BASE_REGENERATION_RATE + int(constitution/30.0)
	
	return hitpoints
	

func init_stamina() -> int:
	
	stamina_max = Constants.BASE_STAMINA + int(constitution * 0.2)
	stamina = stamina_max
	
	stamina_regeneration_rate = Constants.BASE_REGENERATION_RATE + int(constitution / 60.0)
	
	return stamina
	
	
func apply_damage(damage: int) -> int:
	
	if damage < 0:
		return hitpoints
		
	if damage >= hitpoints:
		hitpoints = 0
	else:
		hitpoints -= damage
		
	return hitpoints


func apply_stamina(stamina_drained: int) -> int:
	
	if stamina_drained >= stamina:
		stamina = 0
	else:
		stamina -= stamina_drained
		
	return stamina


func hitpoints_to_string() -> String:
	return "%d/%d" % [hitpoints, hitpoints_max]


func stamina_to_string() -> String:
	return "%d/%d" % [stamina, stamina_max]
	

func check_stamina(stamina_to_use: int) -> bool:
	
	if stamina_to_use > stamina:
		return false
	else:
		return true


func regenerate_stamina():
	
	var regen_stamina = stamina + stamina_regeneration_rate
	
	if regen_stamina > stamina_max:
		stamina = stamina_max
	else:
		stamina = regen_stamina


func regenerate_hitpoints():
	
	var regen_hitpoints = hitpoints + hitpoints_regeneration_rate
	
	if regen_hitpoints > hitpoints_max:
		hitpoints = hitpoints_max
	else:
		hitpoints = regen_hitpoints

		
func attribute_bonus(damage: int, attribute: int, attack_type: int) -> int:
	
	var steps = attribute / Constants.STEP_THRESHOLD
	
	match attack_type:
		
		Constants.ATTACK_TYPES.BASIC:
			return int(damage * steps * Constants.STEP_BASIC_PCT)
		Constants.ATTACK_TYPES.WEAPONS:
			return int(damage * steps * Constants.STEP_WEAPON_PCT)
		Constants.ATTACK_TYPES.SPECIAL:
			return int(damage * steps * Constants.STEP_SPECIAL_PCT)
		_:
			return 0
