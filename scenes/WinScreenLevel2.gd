extends CanvasLayer



func _on_Button_pressed():
		get_tree().change_scene("res://scenes/Level3.tscn")


func _on_Button2_pressed():
	get_tree().quit()
