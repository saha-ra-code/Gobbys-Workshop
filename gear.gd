extends Area2D

var collected = false
@export var lifetime = 3.0
@export var blink_time = 1.5
@export var blink_interval = 0.15



func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	if collected:
		return
		
	var blink_timer = 0.0
	
	while blink_timer < blink_time:
		if collected:
			return
		visible = false
		await get_tree().create_timer(blink_interval).timeout
		
		if collected:
			return
			
		visible = true
		await get_tree().create_timer(blink_interval).timeout
		
		blink_timer += blink_interval * 2.0
		
	if not collected:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.has_method("collect_gear"):
		collected = true
		body.collect_gear()
		set_deferred("monitoring", false)
	 
		var start_position = global_position
		
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		
		tween.tween_method(
			func(progress):
				var target_position = _get_counter_position()
				global_position = start_position.lerp(target_position, progress),
				0.0,
				1.0,
				0.5
				)
				
		tween.tween_property(self, "modulate:a", 0, 0.5)
		tween.tween_property(self, "scale", Vector2 (0.3, 0.3), 0.5) 
		
		await tween.finished
		
		
		queue_free() 

func _get_counter_position() -> Vector2:
	var icon = get_tree().get_first_node_in_group("gear_counter_icon")
	
	if icon == null:
		return global_position
		
	var screen_position = icon.global_position
	var camera = get_viewport().get_camera_2d()
		
	if camera == null:
		return screen_position
		
	var viewport_size = get_viewport_rect().size
	var world_position = camera.get_screen_center_position() + (screen_position - viewport_size / 2.0) / camera.zoom
	return world_position
