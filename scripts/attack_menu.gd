extends CanvasLayer

signal attack_selected(attack_name)
signal weapon_selected(attack_name)

func _on_slap_pressed() -> void:
	attack_selected.emit("slap")


func _on_punch_pressed() -> void:
	attack_selected.emit("punch")


func _on_kick_pressed() -> void:
	attack_selected.emit("kick")
	

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		queue_free()


func _on_weapon_1_pressed() -> void:
	weapon_selected.emit("mouse")


func _on_weapon_2_pressed() -> void:
	weapon_selected.emit("keyboard")
