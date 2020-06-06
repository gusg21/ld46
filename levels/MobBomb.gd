extends AnimatedSprite

var player_path
var velocity
var elapsed = 0

func _process(delta):
	elapsed += delta
	
	velocity = (position - get_node(player_path).position).normalized() * -2
	position += velocity
	
	if elapsed > 4 or get_node(player_path).position.distance_to(position) < 10:
		if animation != "Explode":
			$Explode.play()
		play("Explode")

func _on_MobBomb_animation_finished():
	if animation == "Explode":
		queue_free()
