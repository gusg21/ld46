extends TextureRect

func fade_out():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2, Tween.TRANS_EXPO)
	var wind = get_node("../Wind")
	$Tween.interpolate_property(wind, "volume_db", wind.volume_db, -80, 2, Tween.TRANS_EXPO)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	get_tree().change_scene("res://World Scene.tscn")
