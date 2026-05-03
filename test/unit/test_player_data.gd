extends GutTest

var player: PlayerData

func before_all():

	player = PlayerData.new()


func test_level_up():
	
	player.strength = 10
	player.dexterity = 10
	player.constitution = 10
	player.intelligence = 10
	player.wisdom = 10
	player.charisma = 10
	
	var sum = player.level_up()
	
	assert_eq(player.strength, 13)
	assert_eq(player.dexterity, 12)
	assert_eq(player.constitution, 13)
	assert_eq(player.intelligence, 11)
	assert_eq(player.wisdom, 11)
	assert_eq(player.charisma, 12)
	print(sum)
	assert_eq(sum, "strength:\t\t10 +3\ndexterity:\t\t10 +2\nconstitution:\t10 +3\nintelligence:\t10 +1\nwisdom:\t\t\t10 +1\ncharisma:\t\t10 +2\n")
