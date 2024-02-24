extends CharacterBody2D

@export var speed: int = 50
@onready var animation_player = $AnimationPlayer
@export var maxHealth = 3

@onready var currentHealth = maxHealth

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
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()


func _on_hurt_box_area_entered(area):
	if area.name == "HitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		print_debug(currentHealth)
