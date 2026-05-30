extends CharacterBody2D


var chase = false
var speed = 60
@onready var animation = $AnimatedSprite2D
var alive = true
var damage = 20
var knockback_force = 60
var attack_cooldown = 0.5
var can_attack = true
var player_in_damage = null

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var player = $"../../Player/Player"
	var direction = (player.position - self.position).normalized()
	if alive == true:
		if chase == true:
			velocity.x = direction.x * speed
			animation.play("walk")
		else:
			velocity.x = 0
			animation.play("idle")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h =false
		
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.y -= 250
		death()
		
func _on_damage_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_damage = body
		attack_player()

func _on_damage_body_exited(body: Node2D) -> void:
	if body == player_in_damage:
		player_in_damage = null
		
func  attack_player() -> void:
	if can_attack == false:
		return
	if player_in_damage == null:
		return
	if alive == false:
		return
		
	can_attack = false
	
	var knockback_direction = sign(player_in_damage.global_position.x - global_position.x)
	
	if knockback_direction == 0:
		knockback_direction = 1
		
	player_in_damage.take_damage(damage, knockback_direction, knockback_force)
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	if player_in_damage != null:
		attack_player()
	
	
func death ():
	alive = false
	animation.play("death")
	await animation.animation_finished
	queue_free()
