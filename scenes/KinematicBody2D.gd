extends KinematicBody2D

var arrow: Sprite
var barBackground: Sprite
var greenSpot: Sprite
var speed = 250
var new_speed = 0

var cliques_restantes = 10
var total_de_acertos = 0

var clicou = true

var arrowPlayer : Node2D
var bot1 : KinematicBody2D
var bot2: KinematicBody2D
var bot3: KinematicBody2D
var bot4: KinematicBody2D
var bot5: KinematicBody2D
var bot6: KinematicBody2D
var corda: KinematicBody2D
var bots := []
var arrows := []

var delay_timer = 0
var delay_duration = 2.5

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
	arrowPlayer = get_node("../ArrowPlayer")
	bots = [bot1, bot2, bot3, bot4, bot5, bot6]
	arrows.append(arrowPlayer)
#	bots.append(bot2)
#	bots.append(bot3)
#	bots.append(bot4)
#	bots.append(bot5)
#	bots.append(bot6)
	print(arrows)

func _physics_process(delta):
	var motion = Vector2(speed * delta, 0)
	arrow.position += motion

	var arrowHalfWidth = arrow.texture.get_width() * arrow.scale.x * 0.5
	var barHalfWidth = barBackground.texture.get_width() * barBackground.scale.x * 0.5

	var rightBoundary = barBackground.position.x + barHalfWidth - arrowHalfWidth
	var leftBoundary = barBackground.position.x - barHalfWidth + arrowHalfWidth

	if arrow.position.x > rightBoundary:
		speed = -abs(rand_range(200, 600))
		if clicou:
			cliques_restantes -= 1
			print("Cliques restantes: ", cliques_restantes)
		clicou = true
		
	elif arrow.position.x < leftBoundary:
		speed = abs(rand_range(200, 600))
		if clicou:
			cliques_restantes -= 1
			print("Cliques restantes: ", cliques_restantes)
		clicou = true

	var spotPosition = $GreenSpot.position.x
	
	if Input.is_action_just_pressed("ui_accept"):
		arrowPlayer.sprite.visible = false
		if clicou:
			if arrow.position.x > greenSpot.position.x - 20 and arrow.position.x < greenSpot.position.x + 20:
				total_de_acertos += 1
				cliques_restantes -= 1				
				clicou = false
				for bot in bots:
					bot.animation.play("avanca")
				animacaoTime2ParaTras()
				print("Acertou: ", total_de_acertos)
				print("Cliques restantes: ", cliques_restantes)
			else:
				cliques_restantes -= 1
				clicou = false
				for bot in bots:
					bot.animation.play("tras")
				animacaoTime1ParaTras()
				print("Errou")
				print("Cliques restantes: ", cliques_restantes)
	
	if cliques_restantes + total_de_acertos < 5:
		for bot in bots:
			bot.animation.stop()

		if delay_timer < delay_duration:
			delay_timer += delta
			animacaoVitoria()
		else:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
			delay_timer = 0
		
	if total_de_acertos >= 5:
		for bot in bots:
			bot.animation.stop()
			
		if delay_timer < delay_duration:
			delay_timer += delta
			animacaoPerda()
		else:
			get_tree().change_scene("res://scenes/level2WinScreen.tscn")
			delay_timer = 0

func animacaoTime1ParaTras():
	corda.position.x += 15
	bot3.position.x += 5
	bot2.position.x += 5
	bot1.position.x += 5

func animacaoTime2ParaTras():
	corda.position.x -= 15
	bot6.position.x -= 5
	bot5.position.x -= 5
	bot4.position.x -= 5

func animacaoPerda():
	if delay_timer > 0.2:
		corda.position.x -= 200
	if delay_timer > 0.3:
		bot6.position.x = 64
	if delay_timer > 0.4:
		bot6.position.y += 10
	if delay_timer > 0.5:
		bot5.position.x = 64
	if delay_timer > 0.6:
		bot5.position.y += 10
	if delay_timer > 0.7:
		bot4.position.x = 64
	if delay_timer > 0.8:
		bot4.position.y += 10
		
func animacaoVitoria():
	if delay_timer > 0.2:
		corda.position.x += 200
	if delay_timer > 0.3:
		bot3.position.x = -80
	if delay_timer > 0.4:
		bot3.position.y += 10
	if delay_timer > 0.5:
		bot2.position.x = -80
	if delay_timer > 0.6:
		bot2.position.y += 10
	if delay_timer > 0.7:
		bot1.position.x = -80
	if delay_timer > 0.8:
		bot1.position.y += 10
		
