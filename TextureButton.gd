extends TextureButton


signal timed_clock(success)

export(bool) var pointer_is_over_target

func _on_TimedClickBar_pressed():
	emit_signal("timed_click", pointer_is_over_target)


func _ready():
	pass 

