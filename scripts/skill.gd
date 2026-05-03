class_name Skill

extends Resource

@export var name: String
@export var icon: Texture2D
@export var cost: int
@export var special: SpecialAttack
@export var parents: Array[Skill]
@export var effectiveness: Array[Constants.MONSTER_CLASS]
