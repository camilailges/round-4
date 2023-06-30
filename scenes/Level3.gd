extends Node2D

var platforms := []
var platformsState := []
var player : KinematicBody2D

onready var bridge0: Sprite = get_node("Terrain/Bridge0")
onready var bridge1: Sprite = get_node("Terrain/Bridge1")
onready var bridge2: Sprite = get_node("Terrain/Bridge2")
onready var bridge3: Sprite = get_node("Terrain/Bridge3")
onready var bridge4: Sprite = get_node("Terrain/Bridge4")
onready var bridge5: Sprite = get_node("Terrain/Bridge5")
onready var bridge6: Sprite = get_node("Terrain/Bridge6")
onready var bridge7: Sprite = get_node("Terrain/Bridge7")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("YSort/Player")
	
	generate_platforms()
	platforms.append(bridge0)
	platforms.append(bridge1)
	platforms.append(bridge2)
	platforms.append(bridge3)
	platforms.append(bridge4)
	platforms.append(bridge5)
	platforms.append(bridge6)
	platforms.append(bridge7)

	print(platforms.size())
	print(platforms)
	print(platformsState)

	for i in range(platforms.size()):
		var platform_name = "Bridge" + str(i)
		var platform_sprite = get_node("Terrain/" + platform_name)
		platforms[i].isSafe = platformsState[i]

		if !platformsState[i] && i < platforms.size() - 1:
			platforms[i].visible = false

	yield(get_tree().create_timer(.5), "timeout")

	for i in range(platforms.size()):
		if !platformsState[i] && i < platforms.size() - 1:
			platforms[i].visible = true

#	print(platformsState)

func generate_platforms() -> void:
	var randGen = RandomNumberGenerator.new()
	randGen.randomize()
	for i in range(8):
		if i % 2 == 0:
			platformsState.append(randGen.randf() > 0.5)
		else:
			platformsState.append(!platformsState[i - 1])
			
