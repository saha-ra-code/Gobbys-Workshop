extends CharacterBody2D

signal health_changed(current_health, max_health)
signal gears_changed (current_gears, required_gears)
signal level_completed
signal  died


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimatedSprite2D

var health = 100
var max_health = 100

var gears = 0
var required_gears = 23

var knocked_back = false
var cooldown = 0.2

var is_dead = false


func _physics_process(delta: float) -> void:
	if  is_dead:
		move_and_slide()
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if knocked_back:
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
		
	if velocity.y > 0:
		anim.play("fall")

	move_and_slide()

func take_damage(amount: int, knockback_direction: int, knockback_force:float) -> void:
	if is_dead:
		return
		
	health -= amount
	health = clamp(health, 0, max_health)
	health_changed.emit(health, max_health)
	print("Player health: ", health)
	
	knocked_back = true
	
	velocity.x = knockback_direction * knockback_force
	velocity.y = -100
	await get_tree().create_timer(cooldown).timeout
	knocked_back = false
	
	if health <=0:
		die()
		return

func collect_gear() -> void:
	gears += 1
	gears = clamp(gears, 0, required_gears)
	gears_changed.emit(gears, required_gears)
	print("Gears: ", gears, "/", required_gears)
	
	if gears >= required_gears:
		level_completed.emit()

func die() -> void:
	is_dead = true
	velocity = Vector2.ZERO
	anim.play("death")
	await anim.animation_finished
	died.emit()
