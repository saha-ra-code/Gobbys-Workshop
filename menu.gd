extends Node2D



func _on_play_pressed() -> void:
	$Play.scale = Vector2(.9,.9)
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://level.tscn")


func _on_exit_pressed() -> void:
	$Exit.scale = Vector2(.9,.9)
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()



func _on_play_mouse_entered() -> void:
	$Play.scale = Vector2(1.1, 1.1)


func _on_play_mouse_exited() -> void:
	$Play.scale = Vector2(1,1)


func _on_exit_mouse_entered() -> void:
	$Exit.scale = Vector2(1.1, 1.1)


func _on_exit_mouse_exited() -> void:
	$Exit.scale = Vector2 (1, 1)
