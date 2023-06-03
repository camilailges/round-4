extends KinematicBody2D

onready var animation: AnimationPlayer = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")
onready var level1 = get_tree().get_root().get_node("Level1")

var velocity: Vector2

export(int) var speed

func _physics_process(_delta: float) -> void:
	move()
	verifyDirection()
	animate()
#	print(level1.get("yellow_light"))
#	print(level1.get("red_light"))
	
func move() -> void:
	var directionVector: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	velocity = directionVector * speed
	velocity = move_and_slide(velocity)
	if directionVector != Vector2.ZERO and level1.get("red_light"):
		var _reload: bool = get_tree().reload_current_scene()
	
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
