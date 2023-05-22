extends KinematicBody2D

onready var animation: AnimatedSprite = get_node("Animation")
onready var sprite: Sprite = get_node("Sprite")

var velocity: Vector2

export(int) var speed = 50

func _physics_process(_delta: float) -> void:
	move()
	verifyDirection()
	animate()
	
func move() -> void:
	velocity.x = speed
	velocity = move_and_slide(velocity)
	
func animate() -> void:
	if velocity != Vector2.ZERO:
		if velocity.x != 0:
			$AnimatedSprite.play("walkingSideways")
		else:			
			if velocity.y > 0:
				$AnimatedSprite.play("walkingDown")
			elif velocity.y < 0:
				$AnimatedSprite.play("walkingUp")
	else:
		animation.stop()
				
func verifyDirection() -> void:
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
