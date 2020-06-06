extends AudioStreamPlayer

export(NodePath) var campfire_path = "../../Level 1/Campfire"
export(NodePath) var player_path = "../../Level 1/Player"
var player
var campfire

func fade_out():
	$Tween2.interpolate_property(self, "volume_db", -10.097, -80, 3, Tween.TRANS_EXPO)
	$Tween2.start()

func _on_Tween_timeout():
	play()

func _process(delta):
	campfire = get_node(campfire_path)
	player = get_node(player_path)
	var effect = AudioServer.get_bus_effect(2, 0)
	effect.pan = clamp(-((player.position.x - campfire.position.x) / 300), -0.75, 0.75)
