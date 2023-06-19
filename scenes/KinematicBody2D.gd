extends KinematicBody2D

var speed = 100
var arrow: Sprite
var count = 0
var barBackground: Sprite

func _ready():
	arrow = $Arrow
	barBackground = $BarBackground

func _physics_process(delta):
	var motion = Vector2(speed * delta, 0)  # Positive speed for right to left movement
	arrow.position += motion

	var arrowHalfWidth = arrow.texture.get_width() * arrow.scale.x * 0.5
	var barHalfWidth = barBackground.texture.get_width() * barBackground.scale.x * 0.5

	var rightBoundary = barBackground.position.x + barHalfWidth - arrowHalfWidth
	var leftBoundary = barBackground.position.x - barHalfWidth + arrowHalfWidth

	if arrow.position.x > rightBoundary:
		speed = -abs(speed)
	elif arrow.position.x < leftBoundary:
		speed = abs(speed)

	var spot_position = $GreenSpot.position.x
	if abs(spot_position) < 10:
		if Input.is_action_just_pressed("ui_accept"):
			if abs(arrow.position.x - barBackground.position.x) <= barHalfWidth - arrowHalfWidth:
				count += 1
				print("Count: ", count)
			# Add your logic here for when the player successfully hits the spot
