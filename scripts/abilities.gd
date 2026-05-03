class_name Abilities

extends Resource

const SLOT1: int = 0
const SLOT2: int = 1
const SLOT3: int = 2

var special1: SpecialAttack
var special2: SpecialAttack
var special3: SpecialAttack

@export var specials: Dictionary[String, SpecialAttack]


func add(special: SpecialAttack) -> bool:
	
	if special.name in specials:
		return false
	else:
		specials[special.name] = special
		return true
		

func remove(special: SpecialAttack) -> bool:
	
	if special.name not in specials:
		return false
	else:
		specials.erase(special.name)
		return true
		

func set_slot(slot: int, name: String) -> bool:
	
	if slot == SLOT1:
		special1 = specials[name]
	elif slot == SLOT2:
		special2 = specials[name]
	elif slot == SLOT3:
		special3 = specials[name]
	else:
		print("error: invalid slot")
		return false
	
	return true
