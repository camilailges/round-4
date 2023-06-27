extends KinematicBody2D

var arrow: Sprite
var barBackground: Sprite
var greenSpot: Sprite
var speed = 250
var new_speed = 0

var cliques_restantes = 10
var total_de_acertos = 0

var clicou = true

var bot1 : KinematicBody2D
var bot2: KinematicBody2D
var bot3: KinematicBody2D
var bot4: KinematicBody2D
var bot5: KinematicBody2D
var bot6: KinematicBody2D
var corda: KinematicBody2D
var bots := []

var delay_timer = 0
var delay_duration = 2

func _ready():
	arrow = $Arrow
	barBackground = $BarBackground
	greenSpot = $GreenSpot
	bot1 = get_node("../BotLevel2")
	bot2 = get_node("../Bot2Level2")
	bot3 = get_node("../Bot3Level2")
	bot4 = get_node("../Bot4Level2")
	bot5 = get_node("../Bot5Level2")
	bot6 = get_node("../Bot6Level2")
	corda = get_node("../Corda")
	bots = [bot1, bot2, bot3, bot4, bot5, bot6]
#	bots.append(bot1)
#	bots.append(bot2)
#	bots.append(bot3)
#	bots.append(bot4)
#	bots.append(bot5)
#	bots.append(bot6)

func _physics_process(delta):
	var motion = Vector2(speed * delta, 0)
	arrow.position += motion

	var arrowHalfWidth = arrow.texture.get_width() * arrow.scale.x * 0.5
	var barHalfWidth = barBackground.texture.get_width() * barBackground.scale.x * 0.5

	var rightBoundary = barBackground.position.x + barHalfWidth - arrowHalfWidth
	var leftBoundary = barBackground.position.x - barHalfWidth + arrowHalfWidth

	if arrow.position.x > rightBoundary:
		speed = -abs(rand_range(200, 200))
		if clicou:
			cliques_restantes -= 1
			print("Cliques restantes: ", cliques_restantes)
		clicou = true
		
	elif arrow.position.x < leftBoundary:
		speed = abs(rand_range(200, 200))
		if clicou:
			cliques_restantes -= 1
			print("Cliques restantes: ", cliques_restantes)
		clicou = true

	var spotPosition = $GreenSpot.position.x
	
	if Input.is_action_just_pressed("ui_accept"):
		if clicou:
			if arrow.position.x > greenSpot.position.x - 20 and arrow.position.x < greenSpot.position.x + 20:
				total_de_acertos += 1
				cliques_restantes -= 1				
				clicou = false
				for bot in bots:
					bot.animation.play("avanca")
				corda.position.x -= 15
				print("Acertou: ", total_de_acertos)
				print("Cliques restantes: ", cliques_restantes)
			else:
				cliques_restantes -= 1
				clicou = false
				for bot in bots:
					bot.animation.play("tras")
				corda.position.x += 15		
				print("Errou")
				print("Cliques restantes: ", cliques_restantes)
	
	if cliques_restantes + total_de_acertos < 5:
		corda.position.x += 200
		if delay_timer < delay_duration:
			delay_timer += delta
		else:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
			# Realize a operação que deseja executar após o atraso
			# ...
			# Redefina o temporizador de atraso
			delay_timer = 0
		
		
		
	if total_de_acertos >= 5:
		corda.position.x -= 200
		if delay_timer < delay_duration:
			delay_timer += delta
		else:
			get_tree().change_scene("res://scenes/WinScreen.tscn")
			# Realize a operação que deseja executar após o atraso
			# ...
			# Redefina o temporizador de atraso
			delay_timer = 0
		
