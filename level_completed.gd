extends Control


@onready var player = $"../../Player/Player"
@onready var restart = $VBoxContainer/Restart
@onready var menu = $VBoxContainer/Menu
@onready var quit = $VBoxContainer/Quit


func _ready() -> void:
	visible = false
	
	player.level_completed.connect(_on_level_completed)
	
	restart.pressed.connect(_on_restart_pressed)
	menu.pressed.connect(_on_menu_pressed)
	quit.pressed.connect(_on_quit_pressed)
	
func _on_level_completed() -> void:
	visible = true
	get_tree().paused = true
	
func _on_restart_pressed() ->void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
