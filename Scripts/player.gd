extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")

var velocity: Vector2

export(int) var speed

func _physics_process(_delta: float) -> void:
	move()
	verifyDirection()
	animate()
	
func move() -> void:
	var directionVector: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	velocity = directionVector * speed
	velocity = move_and_slide(velocity)
	
func animate() -> void:
	if velocity != Vector2.ZERO:
		if velocity.x != 0:
			animation.play("walkingSideways")
		else:			
			if velocity.y > 0:
				animation.play("walkingDown")
			elif velocity.y < 0:
				animation.play("walkingUp")
	else:
		animation.stop()
				
func verifyDirection() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
