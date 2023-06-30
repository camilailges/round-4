extends Node2D

var platforms := []
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_platforms()
	print(platforms)
	for i in range(platforms.size()):
		var platform_name = "Bridge" + str(i)
		var platform_sprite = get_node("Terrain/" + platform_name)
#		platform_sprite.isSafe = platforms[i]
		if !platforms[i]:
				platform_sprite.set_visible(false)
		print(platform_name)
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func generate_platforms() -> void:
	for i in range(4):
		var random = randi()
		print(random)
		if random % 2 == 1:
			platforms.append(true)
			platforms.append(false)
		else: 
			platforms.append(false)
			platforms.append(true)
	pass
