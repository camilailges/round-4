extends KinematicBody2D

var arrow: Sprite
var barBackground: Sprite
var greenSpot: Sprite
var speed = 250
var new_speed = 0

var cliques_restantes = 10
var total_de_acertos = 0

var clicou = true

func _ready():
	arrow = $Arrow
	barBackground = $BarBackground
	greenSpot = $GreenSpot

func _physics_process(delta):
	var motion = Vector2(speed * delta, 0)
	arrow.position += motion

	var arrowHalfWidth = arrow.texture.get_width() * arrow.scale.x * 0.5
	var barHalfWidth = barBackground.texture.get_width() * barBackground.scale.x * 0.5

	var rightBoundary = barBackground.position.x + barHalfWidth - arrowHalfWidth
	var leftBoundary = barBackground.position.x - barHalfWidth + arrowHalfWidth

	if arrow.position.x > rightBoundary:
		speed = -abs(rand_range(200, 600))
		clicou = true
		
	elif arrow.position.x < leftBoundary:
		speed = abs(rand_range(200, 600))
		clicou = true

	var spotPosition = $GreenSpot.position.x
	
	if Input.is_action_just_pressed("ui_accept"):
		if clicou:
			if arrow.position.x > greenSpot.position.x - 20 and arrow.position.x < greenSpot.position.x + 20:
				total_de_acertos += 1
				cliques_restantes -= 1				
				clicou = false
				print("Acertou: ", total_de_acertos)
				print("Cliques restantes: ", cliques_restantes)
			else:
				cliques_restantes -= 1
				clicou = false				
				print("Errou")
				print("Cliques restantes: ", cliques_restantes)
	
	if cliques_restantes + total_de_acertos < 5:
		get_tree().change_scene("res://scenes/GameOverScreen.tscn")
		
	if total_de_acertos >= 5:
		get_tree().change_scene("res://scenes/WinScreen.tscn")
