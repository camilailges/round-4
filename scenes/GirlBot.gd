extends KinematicBody2D
#
onready var animation: AnimatedSprite = get_node("AnimatedSprite")
onready var agent: NavigationAgent2D = $GirlBot

var velocity: Vector2
export(int) var speed = 30
export(int) var botRan

func _ready() -> void:
	agent.set_target_location(Vector2(970, 400))
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	botRan = rng.randi_range(1, 4)
	
func _physics_process(delta: float) -> void:
	if agent.is_navigation_finished():
		return
	var direction := global_position.direction_to(agent.get_next_location())
	velocity = direction * speed
	velocity = move_and_slide(velocity)
	animate()


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



