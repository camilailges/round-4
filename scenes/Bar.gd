extends Node2D

var speed = 100
var arrow: Sprite
var count = 0

func _ready():
	arrow = $Arrow

func _process(delta):
	var motion = Vector2(-speed * delta, 0)
	#motion = move_and_slide(motion)

	if position.x < -get_viewport().size.x / 2:
		speed = abs(speed)
		arrow.scale.x = 1  # Set arrow scale to positive to face right
	elif position.x > get_viewport().size.x / 2:
		speed = -abs(speed)
		arrow.scale.x = -1  # Set arrow scale to negative to face left

	var spot_position = $GreenSpot.position.x
	if abs(spot_position) < 10:
		if Input.is_action_just_pressed("ui_accept"):
			count += 1
			# Add your logic here for when the player successfully hits the spot


# Called every frame. 'delta' is the elapsed time since the previous frame.
