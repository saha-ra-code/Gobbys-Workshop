extends Control

@onready var player = $"../../Player/Player"
@onready var restart_button = $VBoxContainer/Restart
@onready var menu_button = $VBoxContainer/Menu
@onready var  quit_button = $VBoxContainer/Quit

func _ready() -> void:
	visible = false
	player.died.connect(_on_player_died)
	
	restart_button.pressed.connect (_restart_button_pressed)
	menu_button.pressed.connect (_menu_button_pressed)
	quit_button.pressed.connect (_quit_button_pressed)
	
func _restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
func _menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
func _quit_button_pressed() -> void:
	get_tree().quit()


func _on_player_died() -> void:
	visible = true
	get_tree().paused = true
