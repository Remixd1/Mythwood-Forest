extends CanvasLayer

@onready var thought_label = $ThoughtsUI

var full_text: String = ""
var char_index: int = 0
var typing_speed: float = 0.05
var typing_timer: float = 0.0
var is_typing: bool = false

func show_thought(text: String):
	full_text = text
	char_index = 0
	thought_label.text = ""
	is_typing = true
	typing_timer = typing_speed

func _process(delta: float) -> void:
	if is_typing:
		typing_timer -= delta
		if typing_timer <= 0.0:
			if char_index < full_text.length():
				thought_label.text += full_text[char_index]
				char_index += 1
				typing_timer = typing_speed
			else:
				is_typing = false

func clear_thought():
	thought_label.text = ""
	is_typing = false
	
