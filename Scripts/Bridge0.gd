extends Sprite

var isSafe: bool
var playerRef = null


var scaleTween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scaleTween = Tween.new()
	add_child(scaleTween)
	
	scaleTween.connect("tween_completed", self, "_on_scale_animation_completed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on__body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		playerRef = body
		print("essa que mudei")
		print("player entrou")
		if !isSafe:
			self.set_visible(false)
			playerRef.set_physics_process(false)
			
			var initialScale = playerRef.sprite.scale
			var targetScale = Vector2(0.5, 0.5)
			var duration = 1.5
			scaleTween.interpolate_property(playerRef.sprite, "scale", initialScale, targetScale, duration, Tween.TRANS_LINEAR)
			scaleTween.start()

# Callback function called when the scale animation is completed
func _on_scale_animation_completed(_object: Object, _key: NodePath) -> void:
	playerRef.queue_free()
	get_tree().change_scene("res://scenes/GameOverScreen.tscn")
	print("Scale animation completed.")


