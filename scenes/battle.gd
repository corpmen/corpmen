extends CanvasLayer

signal battle_finished()

const AttackMenu = preload("res://scenes/attack_menu.tscn")

var attack_menu		= null
var monster 		= null
var attacker		= false
var completed       = false

func _ready() -> void:
	
	# randomize monsters based on map location
	monster = Monster.new("bad manager")
	
	attack_menu = AttackMenu.instantiate()
		
	attack_menu.attack_selected.connect(player_attack)
	
	attack_menu.weapon_selected.connect(player_weapon_attack)
	
	get_tree().root.add_child(attack_menu)
	attack_menu.hide()
	
	attacker = is_attack_initiated()
	
	set_attacker()
	
	toggle_attack_menu(attacker)
	
	update_health_and_stamina()

	$Control/ActionMenu/Exit.disabled = true


func _on_attack_pressed() -> void:
	
	if attack_menu != null:
		attack_menu.show()


func update_health_and_stamina():
	
	$Control/MonsterStatus/GridContainer/Monster1A/MonsterHealth.max_value = monster.hitpoints_max
	$Control/MonsterStatus/GridContainer/Monster1A/MonsterHealth.value = monster.hitpoints
	
	$Control/MonsterStatus/GridContainer/Monster1A/MonsterHealth/MonsterDetail.text = "%d/%d" % [monster.hitpoints, monster.hitpoints_max]
	
	$Control/PlayerStatus/GridContainer/PlayerA/PlayerHealth.max_value = Game.playerData.hitpoints_max
	$Control/PlayerStatus/GridContainer/PlayerA/PlayerHealth.value = Game.playerData.hitpoints

	$Control/PlayerStatus/GridContainer/PlayerA/PlayerHealth/PlayerDetail.text = "%d/%d" % [Game.playerData.hitpoints, Game.playerData.hitpoints_max]

	$Control/PlayerStatus/GridContainer/Stamina/StaminaProgress.max_value = Game.playerData.stamina_max
	$Control/PlayerStatus/GridContainer/Stamina/StaminaProgress.value = Game.playerData.stamina
	
	$Control/PlayerStatus/GridContainer/Stamina/StaminaProgress/StaminaDetail.text = "%d/%d" % [Game.playerData.stamina, Game.playerData.stamina_max]
	
	check_complete()
	

func check_complete() -> void:
	
	if Game.playerData.hitpoints == 0:
		fade_out_rect(true)
		completed = true
		toggle_attack_menu(false)
		$Control/ActionMenu/Exit.disabled = false
		Game.playerData.resurrect()
		
	elif monster.hitpoints == 0:
		fade_out_rect(false)
		completed = true
		summarize()
		$Control/ActionMenu/Exit.disabled = false


func fade_out_rect(is_player) -> void:
	
	var player_image = $Control/Player
	var monster_image = $Control/Monster
	var detail = $Control/ActionDetail
	
	var to_fade = null
	
	var tween = create_tween()
	
	if is_player:
		to_fade = player_image
		detail.text = "Player has been killed..."
	else:
		to_fade = monster_image
		detail.text = "Monster has been killed..."
			
	tween.tween_property(to_fade, "modulate:a", 0.0, 0.1)
	
	
	await tween.finished
	to_fade.hide()


func summarize() -> void:
	
	Game.playerData.update_xp(monster.xp)
	Game.playerData.update_cash(monster.cash)
	Game.playerData.replenish_stamina()
	
	PlayerState.update_player("0")
	
	#todo: loot
	$Control/ActionDetail.text += "\t Gained %d experience and %d cash" % [monster.xp, monster.cash]


func set_attacker():
	
	if attacker:
		$Control/Status.visible = false
	else:
		$Control/Status.visible = true
		await get_tree().create_timer(1.2).timeout
		var res = monster.attack()
		
		$Control/ActionDetail.text = res
		
		hit_flash($Control/Player)
		update_health_and_stamina()
		toggle_attacker()


func toggle_attacker():	
	
	attacker = !attacker
	
	set_attacker()
	toggle_attack_menu(attacker)
	
	
func toggle_attack_menu(state: bool):
	
	if state:
		$Control/ActionMenu/Attack.disabled = false
		$Control/ActionMenu/Item.disabled = false
		$Control/ActionMenu/Special.disabled = false
		$Control/ActionMenu/Flee.disabled = false
		$Control/ActionMenu/Skip.disabled = false
	else:
		$Control/ActionMenu/Attack.disabled = true
		$Control/ActionMenu/Item.disabled = true
		$Control/ActionMenu/Special.disabled = true
		$Control/ActionMenu/Flee.disabled = true
		$Control/ActionMenu/Skip.disabled = true
		
		
func player_attack(attack_type: String) -> void:
	
	var res = Game.playerData.basic_attack(attack_type, monster)
	$Control/ActionDetail.text = res
	
	if res.contains("Not enough stamina"):
		return
	else:
		update_health_and_stamina()
		attack_menu.visible = false
	
	if not completed:
		
		hit_flash($Control/Monster)
		toggle_attacker()
		
		Game.playerData.regenerate_stamina()
		monster.regenerate_stamina()
	

func player_weapon_attack(attack_type: String) -> void:
	
	var res = Game.playerData.weapon_attack(attack_type, monster)
	$Control/ActionDetail.text = res
	update_health_and_stamina()
	attack_menu.visible = false
	
	if not completed:
		hit_flash($Control/Monster)
		toggle_attacker()
	

func hit_flash(node: CanvasItem):
	
	var tween = create_tween()
	
	tween.tween_property(node, "modulate", Color.RED, 0.2)
	tween.tween_property(node, "modulate", Color.WHITE, 0.2)


func flee() -> bool:
	return true


func is_attack_initiated() -> bool:
	
	if Game.rng.randi() == 1:
		return true
	else:
		return false


func _on_exit_pressed() -> void:
	battle_finished.emit()
	

func _on_skip_pressed() -> void:

	attack_menu.visible = false
	toggle_attacker()
	
	Game.playerData.regenerate_stamina()
	monster.regenerate_stamina()
	
