class_name Zone

extends Area2D

@export var zone_id: int


func _ready() -> void:
	
	body_entered.connect(_on_body_entered)
	

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "player":
		
		print("zone: ", zone_id)
		
		Game.playerData.current_zone_id = zone_id
