extends Node2D

@export var mob_scene: PackedScene
@export var respawn_delay = 3.0
@export var max_mobs = 5

var alive_mobs = 0


func _ready() -> void:
	await get_tree().process_frame

	var spawn_points = get_children()
	spawn_points.shuffle()

	var amount = min(max_mobs, spawn_points.size())

	for i in amount:
		spawn_mob_at(spawn_points[i])


func spawn_mob_at(spawn_point: Node2D) -> void:
	if mob_scene == null:
		return

	var mob = mob_scene.instantiate()

	get_parent().add_child(mob)
	mob.global_position = spawn_point.global_position

	alive_mobs += 1
	mob.tree_exited.connect(_on_mob_removed)


func spawn_mob() -> void:
	var spawn_points = get_children()

	if spawn_points.is_empty():
		return

	var spawn_point = spawn_points.pick_random()
	spawn_mob_at(spawn_point)


func _on_mob_removed() -> void:
	alive_mobs -= 1
	alive_mobs = max(alive_mobs, 0)

	if not is_inside_tree():
		return

	await get_tree().create_timer(respawn_delay).timeout

	if not is_inside_tree():
		return

	if alive_mobs < max_mobs:
		spawn_mob()
