extends CharacterBody2D

const Battle = preload("res://scenes/battle.tscn")

const speed = 300.0

var last_direction = DOWN

var battle = null

var is_battle = false


enum {
	WALK_UP,
	WALK_DOWN,
	WALK_LEFT,
	WALK_RIGHT,
	IDLE_UP,
	IDLE_DOWN,
	IDLE_LEFT,
	IDLE_RIGHT
}

enum {
	UP,
	DOWN,
	RIGHT,
	LEFT
}

func _ready():
	
	$AnimatedSprite2D.play("idle_front");


func _physics_process(delta: float) -> void:
	
	if not is_battle:
		player_movement(delta);
		player_idle();
	

func player_movement(_delta: float):
		
	if Input.is_action_just_pressed("ui_up"):
		
		last_direction = UP;
		play_animation(WALK_UP);
		velocity.x = 0;
		velocity.y = -speed;
		
	elif Input.is_action_just_pressed("ui_down"):
		
		last_direction = DOWN;
		play_animation(WALK_DOWN);
		velocity.x = 0;
		velocity.y = speed;
		
	elif Input.is_action_just_pressed("ui_left"):
		
		last_direction = LEFT;
		play_animation(WALK_LEFT);
		velocity.x = -speed;
		velocity.y = 0;
		
	elif Input.is_action_just_pressed("ui_right"):
		
		last_direction = RIGHT;
		play_animation(WALK_RIGHT);
		velocity.x = speed;
		velocity.y = 0;
		
	else:
		
		velocity.x = 0;
		velocity.y = 0;
		
	move_and_slide();
	
	if velocity.x != 0 || velocity.y != 0:
		Game.playerData.regenerate_hitpoints()
		check_encounter()


func player_idle():
	
	if velocity.is_equal_approx(Vector2.ZERO):
	
		match last_direction:
			UP:
				$AnimatedSprite2D.play("idle_back");
			DOWN:
				$AnimatedSprite2D.play("idle_front");
			LEFT:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("idle_side");
			RIGHT:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("idle_side");
		
			
func play_animation(direction):
		
	match direction:
		WALK_UP:
			$AnimatedSprite2D.play("walk_back")
		WALK_DOWN:
			$AnimatedSprite2D.play("walk_front")
		WALK_LEFT:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk_side")
		WALK_RIGHT:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk_side")
			
	
func check_encounter() -> void:

	if Game.rng.randf() < Constants.ENCOUNTER_CHANCE:
	
		if battle == null:
			battle = Battle.instantiate()	
			get_tree().root.add_child(battle)
			is_battle = true
			battle.battle_finished.connect(battle_completed)
			
	
func battle_completed() -> void:
	
	is_battle = false
	battle.queue_free()
