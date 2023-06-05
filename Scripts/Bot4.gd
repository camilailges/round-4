extends KinematicBody2D
#
onready var animation: AnimatedSprite = get_node("AnimatedSprite")
onready var agent: NavigationAgent2D = $Bot4
onready var tombSprite: Sprite = get_node("TombSprite")

var velocity: Vector2
var botSpeed = 75
export(int) var speed = botSpeed
export(int) var botRan

var stopped = false
var won = false

func _ready() -> void:
	agent.set_target_location(Vector2(970, 560))
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	botRan = rng.randi_range(1, 4)
	
func _physics_process(_delta: float) -> void:
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
		
func stop() -> void:
	speed = 0
	
func resume() -> void:
	speed = botSpeed

func kill() -> void:
	animation.visible = false
	tombSprite.visible = true
	set_physics_process(false)

