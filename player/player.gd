extends CharacterBody2D

@export var speed: int = 70
@onready var animation_player = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
func updateAnimation():
	if velocity.length() == 0:
		animation_player.stop()
		return
	
	var direction = "down"
	if velocity.x < 0: direction = "left"
	elif velocity.x > 0: direction = "right"
	elif velocity.y < 0: direction = "up"
	
	animation_player.play("walk_" + direction)
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
