extends ColorRect

@onready var rect = $"."

func fade_and_change_scene(scene_path: String):
	# Fade to black
	var tween = create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, 1.0) # fade in 1s
	tween.finished.connect(func ():
		get_tree().change_scene_to_file(scene_path)
		# After loading, fade back in
		var tween2 = create_tween()
		tween2.tween_property(rect, "modulate:a", 0.0, 1.0))
