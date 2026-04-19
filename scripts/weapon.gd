class_name Weapon

extends Resource

@export var name: String
@export var description: String
@export var type: Constants.WEAPON_TYPE
@export var min_level: int
@export var min_strength: int
@export var min_damage: int
@export var max_damage: int
@export var durability: int
@export var clip: int # ammo that can be stored at once
@export var rarity: Constants.RARITY
@export var texture: Texture2D
