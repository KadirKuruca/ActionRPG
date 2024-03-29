extends CharacterBody2D

var startPosition
var endPosition
@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	
	velocity = moveDirection.normalized() * speed
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateAnimation():
	if velocity.length() == 0:
		if animated_sprite_2d.is_playing():
			animated_sprite_2d.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		
		animated_sprite_2d.play("walk_" + direction)

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
