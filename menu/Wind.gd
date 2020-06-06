extends AudioStreamPlayer

func _ready():
	play()

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "volume_db", -80, -8, 2, Tween.TRANS_LINEAR)
	$Tween.start()
