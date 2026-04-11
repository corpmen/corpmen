extends GutTest

var inventory: Inventory
var bandage = load("res://items/bandage.tres")
var bandaid = load("res://items/bandaid.tres")
var staple = load("res://items/staple.tres")

func before_all():

	inventory = Inventory.new()

	
	
func test_add_inventory():
	
	var s1 = staple.duplicate()
	s1.quantity = 3
	
	var res = inventory.add(s1)
	assert_eq(3, res)
	
	var b1 = bandage.duplicate()
	
	b1.quantity = 1
	res = inventory.add(b1)
	assert_eq(1, res)
	
	assert_eq(inventory.get_stackables(), {"Staple": 3, "Bandage": 1})


func test_add_more_inventory():
	
	var s1 = staple.duplicate()
	var s2 = staple.duplicate()
	
	s1.quantity = 3
	var res = inventory.add(s1)
	assert_eq(3, res)

	
	
	s2.quantity = 10
	res = inventory.add(s2)
	assert_eq(10, res)
	
	assert_eq(inventory.get_stackables(), {"Staple": 16, "Bandage": 1})
	

func test_compact():

	inventory.compact()
	
	assert_eq(inventory.items.size(), 2)


func test_compact_complex():
	
	var s1 = staple.duplicate()
	#var s2 = staple.duplicate()
	
	s1.quantity = 249
	var res = inventory.add(s1)
	
	assert_eq(249, res)
	
	inventory.compact()
	
	assert_eq(inventory.items.size(), 3)
	assert_eq(inventory.items[0].quantity, 250)
	assert_eq(inventory.items[2].quantity, 15)
	
	for item in inventory.items:
		print(item.name, item.quantity)
		

func test_compact_two_shifts():
	
	var s1 = staple.duplicate()
	
	s1.quantity = 200
	var res = inventory.add(s1)
	assert_eq(res, 200)
	
	inventory.compact()
	
	assert_eq(inventory.items.size(), 3)
	assert_eq(inventory.items[2].quantity, 215)
	
	for item in inventory.items:
		print(item.name, item.quantity)


func test_compact_four_shifts():
	
	var s1 = staple.duplicate()
	var s2 = staple.duplicate()
	var s3 = staple.duplicate()
	
	s1.quantity = 250
	var res = inventory.add(s1)
	assert_eq(res, 250)
	
	s2.quantity = 6
	res = inventory.add(s2)
	assert_eq(res, 6)
	
	s3.quantity = 84
	res = inventory.add(s3)
	assert_eq(res, 84)
	
	inventory.compact()
	
	assert_eq(inventory.items.size(), 5)
	assert_eq(inventory.items[2].quantity, 250)
	assert_eq(inventory.items[3].quantity, 250)
	assert_eq(inventory.items[4].quantity, 55)
	
	for item in inventory.items:
		print(item.name, item.quantity)
