extends StaticBody3D

@export var item_name := "Cereal"
@export var interact_text := "Eat Cereal"
signal collected
var collected_already := false

func collect():
	if collected_already:
		return
	collected_already = true
	var sfx = AudioStreamPlayer3D.new()
	sfx.stream = $CollectSound.stream
	get_parent().add_child(sfx)
	sfx.play()
	await get_tree().create_timer(sfx.stream.get_length()).timeout
	sfx.queue_free()
	
	print("Collected:", item_name)
	emit_signal("collected")
	queue_free()
