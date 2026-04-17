# assumption is that the inventory is always compacted while adding items

class_name Inventory


extends Resource

@export var slot_count: int = Constants.DEFAULT_MAX_SLOTS
@export var items: Array[Item] = []


## fills from smallest index to largest skipping itself
##   use index -1 if this item does not yet been added to the inventory
##
func merge_left(name: String, quantity: int, index: int) -> int:
	
	var count = items.size()
	var remaining = quantity
	var merged = 0
	
	for i in range(count):
		
		if i == index:
			break
		else:
			
			if items[i].name == name and items[i].stackable and items[i].quantity < items[i].max:
				
				var delta = items[i].max - items[i].quantity
				
				if delta < remaining:
					
					remaining = remaining - delta
					
					items[i].quantity = items[i].max
					
					merged += delta
					
				else:
					
					items[i].quantity += remaining
					
					merged += remaining
					
					return merged
		
	return merged


func add(item: Resource) -> int:

	if item == null:
		return 0
		
	var count = items.size()
	
	if count == slot_count:
		
		var remaining = merge_left(item.name, item.quantity, -1)
		
		return remaining
	
	elif count < slot_count:
	
		items.append(item)
		
		#compact()
		
		return item.quantity
		
	# see if it exists and can be stacked	
	else:
		return 0


func drop(index: int, quantity: int) -> bool:
	
	# todo: drop quantity
	if quantity == -1:
		pass
		
	if index >= 0 and index < slot_count:
		items.remove_at(index)
		return true
	else:
		print("error: incorrect inventory index ", index)
		return false
	

func swap(from: int, to: int) -> bool:
	
	var count = items.size()
	
	if from < 0 or from >= count:
		return false
	
	if to < 0 or to >= count:
		return false
	
	var temp = items[to]
	
	items[to] = items[from]
	items[from] = temp
	
	return true
	
	
## finds all stackable items and counts
func get_stackables() -> Dictionary:

# i need to know the overall total count
# i also need to know the indexes

	var stackables: Dictionary = {}
	
	var count = items.size()
		
	for i in range(count):
		
		if items[i].stackable:
			
			var val = stackables.get(items[i].name, -1)

			if val != -1:
				stackables[items[i].name] += items[i].quantity
			else:
				stackables[items[i].name] = items[i].quantity
				
	return stackables


func clean() -> void:
	items = items.filter(func(item): return item.quantity > 0)
			


## compacts existing inventory
func compact() -> int:

	var count = items.size()
		
	for i in range(count):
		
		if items[i].stackable and i != 0:
			
			var merged = merge_left(items[i].name, items[i].quantity, i)

			if merged != 0:
				items[i].quantity -= merged

	clean()
	
	return 0	
