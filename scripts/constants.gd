class_name Constants

const MAX_ATTRIBUTE: int	= 300
const MIN_ATTRIBUTE: int	= 1
const MAX_LEVEL: int		= 150
const MIN_DAMAGE: int		= 0

const FIBONACCI_MULTIPLIER: float = 1.5

const BASE_HITPOINTS: int 	= 20
const BASE_STAMINA: int 	= 20
const BASE_REGENERATION_RATE: int		= 1

const STEP_THRESHOLD		= 50
const STEP_BASIC_PCT       	= 0.10
const STEP_WEAPON_PCT       = 0.05
const STEP_SPECIAL_PCT      = 0.03

const MONSTER_ENCOUNTER_CHANCE: float	= 0.1
const LOOT_ENCOUNTER_CHANCE: float	= 0.02

const DEFAULT_MAX_SLOTS: int	= 8

const KEY_MIN: String		= "min"
const KEY_MAX: String		= "max"

const SAVE_PATH: String		= "user://save_%s.tres"

# character classes

const SWE = {
	"strength": {"min": 15, "max": 30},
	"dexterity": {"min": 15, "max": 30},
	"constitution": {"min": 15, "max": 30},
	"intelligence": {"min": 5, "max": 25},
	"wisdom": {"min": 1, "max": 25},
	"charisma": {"min": 5, "max": 30},
	"name": "Software Engineer"
}

const SENIOR_SWE = {
	"strength": {"min": 1, "max": 100},
	"dexterity": {"min": 1, "max": 100},
	"constitution": {"min": 1, "max": 100},
	"intelligence": {"min": 1, "max": 80},
	"wisdom": {"min": 1, "max": 60},
	"charisma": {"min": 1, "max": 100},
	"name": "Senior Software Engineer"
}

const STAFF_SWE = {
	"strength": {"min": 1, "max": 200},
	"dexterity": {"min": 1, "max": 200},
	"constitution": {"min": 1, "max": 200},
	"intelligence": {"min": 1, "max": 100},
	"wisdom": {"min": 1, "max": 100},
	"charisma": {"min": 1, "max": 120},
	"name": "Staff Software Engineer"
}

const PRINCIPAL_SWE = {
	"strength": {"min": 1, "max": 300},
	"dexterity": {"min": 1, "max": 300},
	"constitution": {"min": 1, "max": 300},
	"intelligence": {"min": 1, "max": 150},
	"wisdom": {"min": 1, "max": 120},
	"charisma": {"min": 1, "max": 150},
	"name": "Principal Software Engineer"
}

const SDET = {
	"strength": {"min": 1, "max": 20},
	"dexterity": {"min": 1, "max": 25},
	"constitution": {"min": 1, "max": 30},
	"intelligence": {"min": 1, "max": 25},
	"wisdom": {"min": 1, "max": 25},
	"charisma": {"min": 1, "max": 25},
	"name": "Software Development Engineer in Test"
}

const SENIOR_SDET = {
	"strength": {"min": 1, "max": 25},
	"dexterity": {"min": 1, "max": 40},
	"constitution": {"min": 1, "max": 40},
	"intelligence": {"min": 1, "max": 40},
	"wisdom": {"min": 1, "max": 40},
	"charisma": {"min": 1, "max": 40},
	"name": "Senior Software Development Engineer in Test"
}

const STAFF_SDET = {
	"strength": {"min": 1, "max": 25},
	"dexterity": {"min": 1, "max": 40},
	"constitution": {"min": 1, "max": 40},
	"intelligence": {"min": 1, "max": 40},
	"wisdom": {"min": 1, "max": 40},
	"charisma": {"min": 1, "max": 40},
	"name": "Staff Software Development Engineer in Test"
}

const PRINCIPAL_SDET = {
	"strength": {"min": 1, "max": 25},
	"dexterity": {"min": 1, "max": 40},
	"constitution": {"min": 1, "max": 40},
	"intelligence": {"min": 1, "max": 40},
	"wisdom": {"min": 1, "max": 40},
	"charisma": {"min": 1, "max": 40},
	"name": "Principal Software Development Engineer in Test"
}

const AIE = {
	"strength": {"min": 1, "max": 15},
	"dexterity": {"min": 1, "max": 20},
	"constitution": {"min": 1, "max": 20},
	"intelligence": {"min": 1, "max": 30},
	"wisdom": {"min": 1, "max": 30},
	"charisma": {"min": 1, "max": 20},
	"name": "AI Engineer"
}

const SENIOR_AIE = {
	"strength": {"min": 1, "max": 25},
	"dexterity": {"min": 1, "max": 40},
	"constitution": {"min": 1, "max": 40},
	"intelligence": {"min": 1, "max": 40},
	"wisdom": {"min": 1, "max": 40},
	"charisma": {"min": 1, "max": 40},
	"name": "Senior AI Engineer"
}

const STAFF_AIE = {
	"strength": {"min": 1, "max": 25},
	"dexterity": {"min": 1, "max": 40},
	"constitution": {"min": 1, "max": 40},
	"intelligence": {"min": 1, "max": 40},
	"wisdom": {"min": 1, "max": 40},
	"charisma": {"min": 1, "max": 40},
	"name": "Staff AI Engineer"
}

const PRINCIPAL_AIE = {
	"strength": {"min": 1, "max": 25},
	"dexterity": {"min": 1, "max": 40},
	"constitution": {"min": 1, "max": 40},
	"intelligence": {"min": 1, "max": 40},
	"wisdom": {"min": 1, "max": 40},
	"charisma": {"min": 1, "max": 40}
}

enum CharacterClasses {
	SWE,
	SENIOR_SWE,
	STAFF_SWE,
	PRINCIPAL_SWE,
	SDET,
	SENIOR_SDET,
	STAFF_SDET,
	PRINCIPAL_SDET,
	AIE,
	SENIOR_AIE,
	STAFF_AIE,
	PRINCIPAL_AIE,
	MANAGER,
	SENIOR_MANAGER,
	DIRECTOR,
	SENIOR_DIRECTOR,
	VP,
	PRODUCT_MANAGER,
	SENIOR_PRODUCT_MANAGER,
	PRINCIPAL_PRODUCT_MANAGER
}

const CharacterClassNames = {
	CharacterClasses.SWE: "Software Engineer",
	CharacterClasses.SENIOR_SWE: "Senior Software Engineer",
	CharacterClasses.STAFF_SWE: "Staff Software Engineer",
	CharacterClasses.PRINCIPAL_SWE: "Principal Software Engineer",
	CharacterClasses.SDET: "SDET",
	CharacterClasses.SENIOR_SDET: "Senior SDET",
	CharacterClasses.STAFF_SDET: "Staff SDET",
	CharacterClasses.PRINCIPAL_SDET: "Principal SDET",
	CharacterClasses.AIE: "AI Engineer",
	CharacterClasses.SENIOR_AIE: "Senior AI Engineer",
	CharacterClasses.STAFF_AIE: "Staff AI Engineer",
	CharacterClasses.PRINCIPAL_AIE: "Principal AI Engineer"
}

# attacks

enum ATTACK_TYPES {
	BASIC,
	WEAPONS,
	SPECIAL
}

const ATTACKS = {
	"slap": {"min": 0, "max": 3, "stamina": 1},
	#"bite": {"min": 0, "max": 4, "stamina": 3},
	"backhand": {"min": 0, "max": 5, "stamina": 4},
	"punch": {"min": 3, "max": 6, "stamina": 9},
	"kick": {"min": 4, "max": 6, "stamina": 12},
	#"headbutt": {"min": 5, "max": 10, "stamina": 20},
}

const SPECIAL = {
	"sarcasm": {"min": 7, "max": 12, "stamina": 3, "stress": 8, "satisfaction": 10},
	"useless meeting": {"min": 3, "max": 5, "stamina": 3, "stress": 5, "satisfaction": 20 },
	"life story": {"min": 10, "max": 15, "stamina": 3, "stress": 5, "satisfaction": 20 },
	"boasting": {"min": 10, "max": 15, "stamina": 3, "stress": 5, "satisfaction": 20 },
	"pua": {"min": 10, "max": 5, "stamina": 3, "stress": 5, "satisfaction": 20 },
	"impossible deadline": {"min": 2, "max": 5, "stamina": 3, "stress": 10, "satisfaction": 20 },
	"tps reports": {"min": 3, "max": 8, "stamina": 3, "stress": 5, "satisfaction": 20 },
	"small talk": {"min": 3, "max": 4, "stamina": 10, "stress": 1, "satisfaction": 50 },
	"gossip": {"min": 1, "max": 3, "stamina": 10, "stress": 5, "satisfaction": 2 },
}

const SKILLS = {
	"programming": {
		"code review": {},
		"unit testing": {},
		"debugging": {},
		"design doc": {},
		"observability": {},
		"documentation": {},
		"root cause analysis": {},
		"retrospective": {},
		"commenting": {},
		"refactoring": {},
		"": {},
	}
}

const MONSTERS = {
	"bad manager": {
		"hitpoints": 20, "hitpoints_max": 20, "stamina": 20, "stamina_max": 20,
		"strength": 12, "dexterity": 10, "constitution": 23,
		"intelligence": 10, "wisdom": 10, "charisma": 20, "xp": 10,
		"cash": 200, "is_boss": false,
		"special": [
			"impossible deadline",
			"tps reports",
			"useless meeting"
		]
	},
	"annoying colleague": {
		"hitpoints": 15, "hitpoints_max": 15, "stamina": 20, "stamina_max": 20,
		"strength": 8, "dexterity": 10, "constitution": 18,
		"intelligence": 7, "wisdom": 10, "charisma": 3, "xp": 5,
		"cash": 20, "is_boss": false,
		"special": [
			"small talk",
			"gossip"
		]
	},
	"bug": {"hitpoints": 15, "stamina": 40, "strength": 8,
		"dexterity": 10, "intelligence": 5, "wisdom": 10, "charism": 5},
	"incident": {"hitpoints": 20, "stamina": 20, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
	"hr": {"hitpoints": 17, "stamina": 34, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
	"security exploit": {"hitpoints": 17, "stamina": 34, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
	"auditor": {"hitpoints": 17, "stamina": 34, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
	"expense report": {"hitpoints": 17, "stamina": 34, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
	"passive agressive email": {"hitpoints": 17, "stamina": 34, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
	"deadline": {"hitpoints": 17, "stamina": 34, "strength": 12,
		"dexterity": 10, "intelligence": 10, "wisdom": 10, "charism": 20},
}

enum ITEM_TYPE {
	WEAPON,
	AMMUNITION,
	MEDICAL,
	EDIBLE,
	CRAFTABLE,
	FLAMMABLE,
	EXPLOSIVE
}

enum WEAPON_TYPE {
	SHORT,
	MEDIUM,
	LONG,
}

enum RARITY {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY
}

const ITEMS = {
	"bandaid": {
		"description": "heal small amount of health",
		"type": ITEM_TYPE.MEDICAL,
		"rarity": RARITY.COMMON,
		"hitpoints": 5,
		"stackable": true,
		"max": 25,
		"texture": "res://assets/items/bandaid.png"
	},
	"bandage": {
		"description": "heal medium amount of health",
		"type": ITEM_TYPE.MEDICAL,
		"rarity": RARITY.COMMON,
		"hitpoints": 10,
		"stackable": true,
		"max": 25,
		"texture": "res://assets/items/bandage.png"
	},
	"energy drink": {
		"description": "heals a large amount of health and stamina",
		"type": ITEM_TYPE.MEDICAL,
		"rarity": RARITY.UNCOMMON,
		"hitpoints": 25,
		"stamina": 5,
		"stackable": true,
		"max": 5,
		"texture": "res://assets/items/energy_drink.png"
	},
}

const WEAPONS = {
	"mouse": {
		"description": "a short-range weapon, can be flailed at an enemy",
		"type": ITEM_TYPE.WEAPON,
		"durability": 10,
		"rarity": RARITY.COMMON,
		"min_level": 1,
		"min_strength": 5,
		"min_damage": 3,
		"max_damage": 6,
		"stackable": false,
		"texture": "res://assets/weapons/mouse.png"
	},
	"keyboard": {
		"description": "can be used as a bashing weapon for short range attacks",
		"type": ITEM_TYPE.WEAPON,
		"durability": 10,
		"rarity": RARITY.COMMON,
		"min_level": 1,
		"min_strength": 5,
		"min_damage": 5,
		"max_damage": 10,
		"stackable": false,
		"texture": "res://assets/weapons/keyboard.png"
	},
	"staple gun": {
		"description": "can be used as a medium rang weapon for shooting staples",
		"type": ITEM_TYPE.WEAPON,
		"durability": 15,
		"rarity": RARITY.UNCOMMON,
		"min_level": 2,
		"min_strength": 5,
		"min_damage": 7,
		"max_damage": 12,
		"clip": 20,
		"stackable": false,
		"texture": "res://assets/weapons/staple_gun.png"
	},

}

const AMMUNITION = {
	"staple": {
		"for": "staple gun",
		"description": "for use with staple gun",
		"rarity": RARITY.COMMON,
		"stackable": true,
		"max": 250,
		"texture": "res://assets/ammunition/staple.png"
	},	
}

enum STATES {
	ON,
	OFF
}

const INVENTORY_ACTIONS = [
	"Use",
	"Equip",
	"Drop"
]
