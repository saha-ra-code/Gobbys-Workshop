extends TextureProgressBar

@export var player : CharacterBody2D

func _ready() -> void:
	min_value = 0
	max_value = player.max_health
	value = player.health
	
	player.health_changed.connect(_on_player_health_changed)

func _on_player_health_changed(current_health: int, new_max_health: int) -> void:
	max_value = new_max_health
	value = current_health
