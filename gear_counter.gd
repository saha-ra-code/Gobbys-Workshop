extends HBoxContainer

@onready var player = $"../../Player/Player"
@onready var gear_label = $GearLabel

func _ready() -> void:
	gear_label.text = str(player.gears, "/", player.required_gears)
	player.gears_changed.connect(_gears_changed)
	
func _gears_changed(current_gears, required_gears) -> void:
	gear_label.text = str(current_gears, "/", required_gears)
