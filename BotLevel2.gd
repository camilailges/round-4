extends KinematicBody2D

onready var animation: AnimatedSprite = get_node("AnimatedSprite")
var bar: KinematicBody2D
var bots := []

func _ready() -> void:
	bar = get_node("../Bar")
	bots.append(bar)
	print("bots: ", bots)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
