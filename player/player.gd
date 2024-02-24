extends CharacterBody2D

signal player_get_hit(current_health: int)

@export var speed: int = 50
@export var max_health = 3
@export var knock_back_value = 700

@onready var animation_player = $AnimationPlayer
@onready var current_health = max_health
@onready var effects = $Effects
@onready var hurt_timer = $HurtTimer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animation_player.is_playing():
			animation_player.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		
		animation_player.play("walk_" + direction)
		
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func knock_back(enemy_velocity: Vector2):
	var knock_back_direction = (enemy_velocity - velocity).normalized() * knock_back_value
	velocity = knock_back_direction
	move_and_slide()
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()

func _on_hurt_box_area_entered(area):
	if area.name == "HitBox":
		current_health -= 1
		if current_health < 0:
			current_health = max_health
			
	player_get_hit.emit(current_health)
	knock_back(area.get_parent().velocity)
	handle_hurt_animations()
	
func handle_hurt_animations():
	effects.play("hurt_blink")
	hurt_timer.start()
	await hurt_timer.timeout
	effects.play("RESET")
