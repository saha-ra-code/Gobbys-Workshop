extends Control

@onready var dialog_label = $Panel/DialogLabel
@onready var continue_button = $Panel/Next

var curent_line = 0

var lines = [
	"Hey there! I am Gobbi, inventor, tinkerer, and occasional victim of my own excellent ideas.",
	"I have big plans, but first I need to collect the gears in this forest (not surprising, really, I am the one who keeps losing them here).",
	"Help me gather 10 gears. They disappear real fast! Turn around for one second and poof, gone! So be quick!",
	"Oh, and there is one more tini-tiny thing. This forest is full of slimes. They are cute. As long as you do not get too close."
]

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)
	
	if GameState.intro_show:
		visible = false
		get_tree().paused = false
		return
	GameState.intro_show = true
		
	get_tree().paused = true
	visible = true
	
	dialog_label.text = lines [curent_line]
	continue_button.text = "Next"
	

	
func _on_continue_pressed() -> void:
	curent_line +=1
	
	if curent_line >= lines.size():
		visible = false
		get_tree().paused = false
		return
		
	dialog_label.text = lines[curent_line]
	
	if curent_line == lines.size() - 1:
		continue_button.text = "Start"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
