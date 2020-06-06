extends Label

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 4, Tween.TRANS_EXPO)
	$Tween.start()
