extends Node2D


func  _ready() -> void:
	$CanvasLayer/AnimationPlayer.play("fade_out")
