class_name GlobalData

extends Node

var rng: RandomNumberGenerator

var playerData: PlayerData


func _ready() -> void:
	
	rng = RandomNumberGenerator.new()
			
	rng.randomize()


func create_player(new_name: String) -> void:
	
	#playerData = PlayerState.generate_player(Constants.SWE, new_name)
	playerData = PlayerState.load_player("0")
