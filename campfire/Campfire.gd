extends "../ZSortedStaticBody.gd"

export(NodePath) var player_path

onready var max_health = 100.0
onready var health = 100.0
onready var time_to_live = 60

var play_dead = false

func _ready():
	set_meta("type", "campfire")

func _process(delta):
	if get_node(player_path).is_safe():
		time_to_live = 20
	else:
		time_to_live = 60
	
	health -= ((delta) / time_to_live) * max_health
	$"Graphics/Health BG/Health".set_point_position(1, Vector2((health / max_health)*34-17, 17))
	
	if health <= 0:
		if play_dead:
			$Dead.play()
			play_dead = false
		health = 0
	if health > max_health:
		health = max_health
	
	$Graphics/Light2D.texture_scale = 0.2 * (((health / max_health) * 0.5) + 0.5)

	if health == 0:
		$Graphics.play("Dead")
		$Graphics/Light2D.enabled = false
	elif health < 50:
		$Graphics.play("Small")
	elif health <= 100:
		$Graphics.play("Big")
	
	._process(delta)
