extends Control

@onready var text_label = $TextLabel
@onready var name_label = $NameLabel

var typing_speed := 0.04
var typing_timer := 0.0
var full_text := ""
var visible_chars := 0
var typing := false
var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func show_line(speaker: String, text: String):
	visible = true
	active = true
	name_label.text = speaker
	full_text = text
	visible_chars = 0
	typing = true
	typing_timer = 0.0
	text_label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if typing:
		typing_timer -= delta
		if typing_timer <= 0:
			typing_timer = typing_speed
			visible_chars += 1
			text_label.text = full_text.substr(0, visible_chars)
			if visible_chars >= full_text.length():
				typing = false

func skip_typing():
	text_label.text = full_text
	typing = false

func hide_box():
	visible = false
	active = false
