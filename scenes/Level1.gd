extends Node2D




var yellow_light: bool = false
var red_light: bool = false 

var GREEN_LIGHT_INTERVAL: float = randi() % 5 
const YELLOW_LIGHT_INTERVAL: float = 1.0 
const RED_LIGHT_INTERVAL: float = 4.0 

const GAME_TIME: float = 10.0
var game_time_count: float = 0.0

var green_light_time: float = 0.0 
var yellow_light_time: float = 0.0 
var red_light_time: float = 0.0

enum {redLight, greenLight, yellowLight}

var light_label
var green_light_label_sprite
var yellow_light_label_sprite
var red_light_label_sprite

var qtdVermelhos = 0
#var botParou = false

var player : KinematicBody2D

var bot1 : KinematicBody2D
var bot2: KinematicBody2D
var bot3: KinematicBody2D
var bot4: KinematicBody2D

var bots := []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("YSort/Player")
	
	bot1 = get_node("Navigation2D/GirlBot")
	bot2 = get_node("Navigation2D/Bot2")
	bot3 = get_node("Navigation2D/Bot3")
	bot4 = get_node("Navigation2D/Bot4")
	
	bots.append(bot1)
	bots.append(bot2)
	bots.append(bot3)
	bots.append(bot4)
	
	
	light_label = get_node("LightLabel")
	green_light_label_sprite = light_label.get_node("GreenLightSprite")
	yellow_light_label_sprite = light_label.get_node("YellowLightSprite")
	red_light_label_sprite = light_label.get_node("RedLightSprite")
	update_lights()

func update_lights():
	green_light_label_sprite.visible = !red_light and !yellow_light
	yellow_light_label_sprite.visible = yellow_light
	red_light_label_sprite.visible = red_light

func _process(delta: float) -> void:
	update_lights()
	if not red_light and not yellow_light:
		green_light_time += delta
		
	if green_light_time >= GREEN_LIGHT_INTERVAL:
		yellow_light = true
		green_light_time = 0.0
		GREEN_LIGHT_INTERVAL = randi() % 6

	if yellow_light: 
		yellow_light_time += delta
	
	if yellow_light_time >= YELLOW_LIGHT_INTERVAL:
		red_light = true
		yellow_light = false
		yellow_light_time = 0.0
		qtdVermelhos += 1
		
	for bot in bots:
		if !yellow_light && !red_light && bot.stopped == true:
			bot.resume()
	
		
	if red_light:
		if player.velocity != null and player.velocity != Vector2.ZERO:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
		for bot in bots:
			if qtdVermelhos != bot.botRan:
				bot.stop()
				bot.stopped = true
			else:
				bot.kill()
			

			
		red_light_time += delta
		if red_light_time >= RED_LIGHT_INTERVAL:
			red_light = false
			red_light_time = 0.0
			player.sprite.visible=true
	
	if game_time_count >= 15:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
	
	game_time_count += delta
	
	if player.global_position.x > 930:
		get_tree().change_scene("res://scenes/WinScreen.tscn")
	





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
