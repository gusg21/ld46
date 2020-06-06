extends "../ZSortedBody.gd"

export(NodePath) var player_path
export(String, "Normal", "Elite") var mobster_type = "Elite"

var DAMAGE_MAP = { # knockback, damage
	"Normal" : [10, 9, preload("res://mobsters/MobsterFrames.tres"), 50],
	"Elite" : [5, 15, preload("res://mobsters/EliteMobsterFrames.tres"), 75]
}

onready var velocity:Vector2 = Vector2.ZERO
onready var followingPlayer = false

func _ready():
	set_meta("type", "mobster")
	
	$Graphics.frames = DAMAGE_MAP[mobster_type][2]

func _process(delta):
	var t_velocity
	var player = get_node(player_path)
	if followingPlayer and !player.is_safe():
		t_velocity = (player.position - position).normalized() * DAMAGE_MAP[mobster_type][3]
	else:
		t_velocity = Vector2.ZERO
	velocity = lerp(velocity, t_velocity, 0.1)
	if player.is_safe() or $Graphics.animation == "Die":
		velocity = Vector2.ZERO
	move_and_slide(velocity)
	
	if velocity.length() != 0:
		if velocity.x > 0:
			$Graphics.flip_h = true
		else:
			$Graphics.flip_h = false
		
		if $Graphics.animation != "Attack":
			$Graphics.play("Walk")
	else:
		if $Graphics.animation != "Attack":
			$Graphics.play("Idle")
	
	._process(delta)

func _on_Visiblity_Enter_area_entered(area):
	if area.get_parent().get_meta("type") == "player":
		followingPlayer = true

func _on_Visibility_Exit_area_exited(area):
	if area.get_parent().get_meta("type") == "player":
		followingPlayer = false


func _on_Hitbox_area_entered(area):
	if area.get_parent().get_meta("type") == "player":
		var player = area.get_parent()
		if player.attacking:
			velocity = velocity * -10
			$Sounds/Hurt.play()
		else:
			$Graphics.play("Attack")
			player.hit(velocity * DAMAGE_MAP[mobster_type][0], DAMAGE_MAP[mobster_type][1])
			velocity *= -3


func _on_Step_Sound_Timer_timeout():
	if velocity.length() != 0:
		$Sounds/Step.volume_db = 0 - position.distance_to(get_node(player_path).position) / 10
		$Sounds/Step.play()


func _on_Graphics_animation_finished():
	if $Graphics.animation == "Die":
		queue_free()
	if $Graphics.animation == "Attack":
		$Graphics.play("Walk")
