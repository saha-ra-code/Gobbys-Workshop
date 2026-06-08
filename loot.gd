extends Node

var gear = preload("res://gear.tscn")


func _on_timer_timeout() -> void:
	var geartemp = gear.instantiate()
	geartemp.position = Vector2(randf_range(15,1125),465)
	add_child(geartemp)
