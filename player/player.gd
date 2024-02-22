extends CharacterBody2D

@export var speed: int = 70

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
func _physics_process(delta):
	handleInput()
	move_and_slide()