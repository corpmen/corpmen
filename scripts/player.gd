extends CharacterBody2D

const Battle = preload("res://scenes/battle.tscn")

const MONSTER_ENCOUNTER_STEPS_MIN: float = 400.0
const MONSTER_ENCOUNTER_STEPS_MAX: float = 1200.0

@export var speed = 150

var last_direction = DOWN

var battle = null

var is_battle = false

var next_encounter_distance: float = 0.0


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
	
	set_random_encounter_distance()


func _physics_process(delta: float) -> void:
	
	if not is_battle:
		player_movement(delta);
		player_idle();
	

func set_random_encounter_distance() -> void:
	
	next_encounter_distance = Game.rng.randf_range(\
	  MONSTER_ENCOUNTER_STEPS_MIN, \
	  MONSTER_ENCOUNTER_STEPS_MAX)
	
	
func player_movement(delta: float):
	
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * speed
	
	if Input.is_action_pressed("ui_up"):
		
		last_direction = UP;
		play_animation(WALK_UP);

		
	elif Input.is_action_pressed("ui_down"):
		
		last_direction = DOWN;
		play_animation(WALK_DOWN);

		
	elif Input.is_action_pressed("ui_left"):
		
		last_direction = LEFT;
		play_animation(WALK_LEFT);

		
	elif Input.is_action_pressed("ui_right"):
		
		last_direction = RIGHT;
		play_animation(WALK_RIGHT);
		
	move_and_slide();
	
	next_encounter_distance -= velocity.length() * delta
	
	# todo: regenerate hitpoints more slowly
	if velocity.x != 0 || velocity.y != 0:
		Game.playerData.regenerate_hitpoints()
	
	if next_encounter_distance <= 0:
		battle_start()
		set_random_encounter_distance()


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
			
	
func battle_start() -> void:
	
	if battle == null:
		battle = Battle.instantiate()
		get_tree().root.add_child(battle)
		is_battle = true
		battle.battle_finished.connect(battle_completed)
			
	
func battle_completed() -> void:
	
	is_battle = false
	battle.queue_free()
