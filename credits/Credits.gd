extends RichTextLabel

func _process(delta):
	rect_position.y -= 0.2 + Input.get_action_strength("ui_select") * 3
	if rect_position.y < -748:
		get_tree().quit()
	
