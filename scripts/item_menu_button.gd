extends MenuButton


signal action_selected(button_name, item_id)


func _ready():
	
	pass
	
 
func _on_id_pressed(id: int):
	
	action_selected.emit(self.name, id)
