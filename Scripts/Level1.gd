extends Node2D


onready var green_light_label: Label = get_node("GreenLightLabel")
onready var yellow_light_label: Label = get_node("YellowLightLabel")
onready var red_light_label: Label = get_node("RedLightLabel")

var yellow_light: bool = false
var red_light: bool = false 

var GREEN_LIGHT_INTERVAL: float = randi() % 5 
const YELLOW_LIGHT_INTERVAL: float = 2.0 
const RED_LIGHT_INTERVAL: float = 3.0 

var green_light_time: float = 0.0 
var yellow_light_time: float = 0.0 
var red_light_time: float = 0.0

var player : KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("Player")

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
		player = get_node("Player")
		if player.velocity != Vector2.ZERO:
			player.get
			player.animation.play("death")
		red_light_time += delta
		if red_light_time >= RED_LIGHT_INTERVAL:
			red_light = false
			red_light_time = 0.0
			
	green_light_label.text = "Green Light: " + str(round(green_light_time))
	red_light_label.text = "Red Light: " + str(round(red_light_time))
	yellow_light_label.text = "Yellow Light: " + str(round(yellow_light_time))




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
