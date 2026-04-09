extends GutTest

func test_calculate_damage_punch():

	var c = Combat.new()
	
	var damage = c.calculate_damage("punch")
	
	assert_gte(damage, Constants.ATTACKS["punch"]["min"])
	assert_lte(damage, Constants.ATTACKS["punch"]["max"])
	
