extends "../ZSortedBody.gd"

export(NodePath) var player_path
onready var velocity = Vector2.ZERO
var MOBBOMB = preload("res://mobsters/MobBomb.tscn")

func _ready():
	set_meta("type", "mobster")

func _process(delta):
	var player = get_node(player_path)
	var move_vec = (position - player.position).normalized() * -40
	
	velocity = lerp(velocity, move_vec, 0.1)
	
	if velocity.length() != 0:
		if velocity.x > 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
	
	move_and_slide(velocity)
	
	._process(delta)


func _on_AnimatedSprite_animation_finished():
	$Step.play()

func _on_Hitbox_area_entered(area):
	if area.get_parent().get_meta("type") == "player":
		var player = area.get_parent()
		if player.attacking:
			velocity = velocity * -17
			$Hurt.play()
		else:
			player.hit(velocity * 10, 10)
			velocity *= -3


func _on_Timer_timeout():
	var bomb = MOBBOMB.instance()
	bomb.position += Vector2(-16 * 4, -16)
	bomb.player_path = player_path
	get_parent().add_child(bomb)
