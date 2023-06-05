extends Node2D


onready var green_light_label: Label = get_node("GreenLightLabel")
onready var yellow_light_label: Label = get_node("YellowLightLabel")
onready var red_light_label: Label = get_node("RedLightLabel")

const GameOverScreen = preload("res://Scripts/GameOverScreen.gd")

var yellow_light: bool = false
var red_light: bool = false 

var GREEN_LIGHT_INTERVAL: float = randi() % 5 
const YELLOW_LIGHT_INTERVAL: float = 1.0 
const RED_LIGHT_INTERVAL: float = 4.0 

var green_light_time: float = 0.0 
var yellow_light_time: float = 0.0 
var red_light_time: float = 0.0

enum {redLight, greenLight, yellowLight}

var player : KinematicBody2D
var bot : KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("YSort/Player")
	bot = get_node("Navigation2D/GirlBot")

func _process(delta: float) -> void:
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
		
	if red_light:
#		if bot.velocity != null and bot.velocity != Vector2.ZERO:
#			bot.animation.visible = false
		if player.velocity != null and player.velocity != Vector2.ZERO:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
			
		red_light_time += delta
		if red_light_time >= RED_LIGHT_INTERVAL:
			red_light = false
			red_light_time = 0.0
			player.sprite.visible=true
			
	green_light_label.text = "Green Light: " + str(round(green_light_time))
	red_light_label.text = "Red Light: " + str(round(red_light_time))
	yellow_light_label.text = "Yellow Light: " + str(round(yellow_light_time))
	
	if player.global_position.x > 930:
		get_tree().change_scene("res://scenes/WinScreen.tscn")
		
#func win():
#	get_tree().change_scene("res://scenes/WinScreen.tscn")
#	var game_over = GameOverScreen.instance()
#	add_child(game_over)
#
#func lose():
#	var game_over = GameOverScreen.instance()
#	add_child(game_over)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
