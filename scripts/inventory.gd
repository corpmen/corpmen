class_name Inventory

extends Resource


var slots: int = Constants.DEFAULT_MAX_SLOTS
var items: Array = []


func load_item(name: String, quantity: int) -> Item:
	
	if quantity <= 0:
		return null
		
	var item = Constants.ITEMS.get(name)
	
	#todo: if doesn't exist
	
	var new_item = Item.new()
	
	new_item.name = name
	new_item.description = item.description
	new_item.type = item.type
	
	new_item.quantity = quantity
	new_item.stackable = item.stackable
	new_item.durability = item.durability
	new_item.max = item.max
	new_item.hitpoints = item.hitpoints
	new_item.stamina = item.stamina
	
	return new_item

	
func add_item(name: String, quantity: int) -> int:

	var count = items.size()
	
	if count == slots:
		
		var remaining = compact_new(name, quantity)
		
		return remaining
	
	elif count < slots:
	
		var item = load_item(name, quantity)
		
		if item == null:
			return 0
		
		items.append(item)
		
		return quantity
		
	# see if it exists and can be stacked	
	else:
		return 0

	
	
func compact_new(name: String, quantity: int) -> int:
	
	var to_absorb = quantity
	
	var item = Constants.ITEMS.get(name)
	
	if !item.stackable:
		return 0
	
	for i in items:
		
		if i.name == name:
			
			if i.quantity < i.max:
				
				var delta = i.max - i.quantity
				
				if delta >= to_absorb:
					
					i.quantity += to_absorb
					
					return true
					 
				else:
					
					i.quantity += delta
					
					to_absorb -= delta
					
	return to_absorb
				
				
	
