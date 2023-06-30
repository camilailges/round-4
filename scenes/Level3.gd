extends Node2D

var platforms := []
var platformsState := []
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
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
		if !platformsState[i]:
				platform_sprite.set_visible(false)
		print(platform_name)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func generate_platforms() -> void:
	for i in range(4):
		var random = randi()
		print(random)
		if random % 2 == 1:
			platformsState.append(true)
			platformsState.append(false)
		else: 
			platformsState.append(false)
			platformsState.append(true)
	pass


