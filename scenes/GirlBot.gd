extends KinematicBody2D
#
#onready var animation: AnimatedSprite = get_node("AnimatedSprite")
#onready var sprite: Sprite = get_node("Sprite")
#onready var _agent: NavigationAgent2D = $NavigationAgent2D
#
#
#var velocity: Vector2
#
#export(int) var speed = 1
#
#func _physics_process(_delta: float) -> void:
#	_agent.get_next_location()
#	move()
#	verifyDirection()
#	animate()
#
#func move() -> void:
#	var passou = false
#	velocity.x = speed
##	velocity = move_and_slide(velocity)
#	var collision = move_and_collide(velocity)
#
#	if collision:
##		passou = true
#		#var collidedObject = collision.collider
#		#if collidedObject.name == "Arvore2":  # Replace "Tree" with the actual name of your tree object
#			# Calculate new direction by rotating the current direction 90 degrees
#		var newDirection = velocity.rotated(90)
#		#animation.play("walkingDown")
#		#print("entrou")
#		velocity = newDirection.normalized() * speed  # Normalize the vector to maintain the original speed
#		move_and_collide(velocity)
#		#var newDirection2 = velocity.rotated(90)
#		#animation.play("walkingDown")
##		print("entrou")
##		velocity = newDirection2.normalized() * speed  # Normalize the vector to maintain the original speed
##		move_and_collide(velocity)
#
#
#func animate() -> void:
#	if velocity != Vector2.ZERO:
#		if velocity.x != 0:
#			animation.play("walkingSideways")
#		else:			
#			if velocity.y > 0:
#				animation.play("walkingDown")
#			elif velocity.y < 0:
#				animation.play("walkingUp")
#	else:
#		animation.stop()
#
#func verifyDirection() -> void:
#	if velocity.x > 0:
#		animation.flip_h = false
#	elif velocity.x < 0:
#		animation.flip_h = true
#
##func _on_detection_area_body_entered(body) -> void:
##	print("entrou")
##	animation.play("walkingDown")
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	_agent.set_target_location(Vector2(970, self.global_position.y))
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta: float) -> void:
##	pass


onready var agent: NavigationAgent2D = $NavigationAgent2D

var velocity: Vector2
export(int) var speed = 90

func _ready() -> void:
	agent.set_target_location(Vector2(970, 548))
	
func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(agent.get_next_location())
	velocity = direction * speed
	velocity = move_and_slide(velocity)




