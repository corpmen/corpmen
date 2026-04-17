extends GutTest

var inventory: Inventory
var bandage = load("res://items/bandage.tres")
var bandaid = load("res://items/bandaid.tres")
var staple = load("res://items/staple.tres")
var stapler = load("res://items/stapler.tres")

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
	


func test_compact_two_shifts():
	
	var s1 = staple.duplicate()
	
	s1.quantity = 200
	var res = inventory.add(s1)
	assert_eq(res, 200)
	
	inventory.compact()
	
	assert_eq(inventory.items.size(), 3)
	assert_eq(inventory.items[2].quantity, 215)



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
	

func test_add_full():
	
	for i in range(11):
		
		var s = stapler.duplicate()
	
		s.quantity = 1
		var res = inventory.add(s)
		assert_eq(res, 1)
		
	assert_eq(inventory.items.size(), 16)
	
	var s = stapler.duplicate()
	
	s.quantity = 1
	var res = inventory.add(s)
	assert_eq(res, 0)

	assert_eq(inventory.items.size(), 16)


func test_compact_overflow():
	
	var s = staple.duplicate()
	
	s.quantity = 250
	var res = inventory.add(s)
	assert_eq(res, 195)

	assert_eq(inventory.items.size(), 16)
	assert_eq(inventory.items[4].quantity, 250)


func test_remove_negative_index():
	
	var res = inventory.remove(-1)
	
	assert_eq(res, false)

	assert_eq(inventory.items.size(), 16)


func test_remove_out_of_bounds_index():
	
	var res = inventory.remove(20)
	
	assert_eq(res, false)

	assert_eq(inventory.items.size(), 16)


func test_remove_index():
	
	var res = inventory.remove(3)
	assert_eq(res, true)

	assert_eq(inventory.items.size(), 15)
