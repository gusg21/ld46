extends "ZSortedBody.gd"

export(float) var move_speed
export(NodePath) var campfire_path
export(float) var health_loss = 0.06

onready var velocity:Vector2 = Vector2.ZERO
onready var inventory = []
onready var attacking = false
onready var can_attack = true
onready var max_health = 100.0
onready var health = 100.0
onready var can_move = true
	
func is_safe():
	var campfire = get_node(campfire_path)
	return campfire.position.distance_to(position) < 40 and campfire.get_node("Graphics").animation != "Dead"

func _ready():
	set_meta("type", "player")

func _process(delta):
	var move_vec = Vector2(
	   Input.get_action_strength("right") - Input.get_action_strength("left"),
	   Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	move_vec = move_vec.normalized()
	var move_speed_adjusted = move_speed - (1 * len(inventory))
	move_vec = move_vec * move_speed_adjusted
	if !can_move:
		move_vec = Vector2.ZERO
	
	velocity = lerp(velocity, move_vec, 0.1)

	move_and_slide(velocity)

	if move_vec.length() != 0:
		if move_vec.x < 0:
			$Graphics.flip_h = true
		else:
			$Graphics.flip_h = false
		
		if not attacking:
			$Graphics.play("Walk")
	else:
		if not attacking:
			$Graphics.play("Idle")

	var overlapping_areas = $"Player Hitbox".get_overlapping_areas()
	
	var campfire = null
	
	$"E Icon".visible = false
	for area in overlapping_areas:
		var p = area.get_parent()
		if !p.get_parent().has_meta("type"):
			if !p.has_meta("type"):
				continue
		
		if p.has_meta("type"):
			var p_type = p.get_meta("type")
			if p_type == "log":
				if p.get_meta("in_inv") == false:
					$"E Icon".visible = true
					$"E Icon".red_x = len(inventory) >= 3
					if Input.is_action_just_pressed("interact") and can_move and len(inventory) < 3:
						inventory.append(p)
						p.set_meta("in_inv", true)
						$"Sounds/Log Grab".play()
						break
			if p_type == "logletter":
				$"E Icon".visible = true
				if Input.is_action_just_pressed("interact"):
					if p.letter_open:
						p.hide_letter()
						can_move = true
					else:
						p.show_letter()
						can_move = false
		
		if p.get_parent().has_meta("type"):
			if p.get_parent().get_meta("type") == "campfire":
				campfire = p.get_parent()

	$"Q Icon".visible = (campfire != null) and (len(inventory) != 0)
	
	if Input.is_action_just_pressed("drop"):
		if len(inventory) != 0:
			var item = inventory.pop_back()
			item.set_meta("in_inv", false)
			if campfire != null:
				if campfire.health > 0:
					if item.item_type == "Log":
						campfire.health += 25
					elif item.item_type == "Stick":
						campfire.health += 12.513
					elif item.item_type == "Gasoline":
						campfire.health = 100
					item.queue_free()
					$"Sounds/Log Added".play()
	
	if Input.is_action_just_pressed("attack") and can_attack:
		$Graphics.play("Attack")
		attacking = true
		can_attack = false
		if health_loss > 0:
			health -= 5
		$"Attack Cooldown".start()
	
	var i = 0
	for item in inventory:
		item.position = position + Vector2(0, -22 - (i*8))
		item.z_index = 1000
		i += 1

	campfire = get_node(campfire_path)
	if is_safe() and campfire.health != 0:
		health += 0.6
		$Sounds/Heal.volume_db = -28.272
	else:
		health -= health_loss
		$Sounds/Heal.volume_db = -80
	$"Health BG/Health".set_point_position(1, Vector2((health / max_health)*34-17, 17))
	
	if health <= 0:
		health = 0
		get_tree().change_scene("res://gameover/GameOver.tscn")
	if health > max_health:
		health = max_health

	._process(delta)

func hit(knockback_vec, damage):
	velocity = knockback_vec
	health -= damage
	$Sounds/Hurt.play()

func _on_Graphics_animation_finished():
	if $Graphics.animation == "Attack":
		attacking = false


func _on_Attack_Cooldown_timeout():
	can_attack = true
	$Sounds/Cooldown.play()
