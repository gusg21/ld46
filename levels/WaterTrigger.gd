extends Area2D

func _on_Area2D_area_entered(area):
	if area.get_parent().get_meta("type") == "mobster":
		get_tree().change_scene("res://you win/you win.tscn")
