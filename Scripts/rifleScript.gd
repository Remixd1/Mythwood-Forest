extends StaticBody3D

@export var item_name := "Rifle"
@export var interact_text := "Hunting Rifle"
var collected := false
var can_pickup := false
signal gunLine1
signal gunGet

func collect():
	if collected:
		return
	if can_pickup:
		collected = true
		var sfx = AudioStreamPlayer3D.new()
		sfx.stream = $CollectSound.stream
		get_parent().add_child(sfx)
		sfx.play()
		await get_tree().create_timer(sfx.stream.get_length()).timeout
		sfx.queue_free()
	
		print("Collected:", item_name)
		emit_signal("gunGet")
		$"../CharacterBody3D/CanvasLayer".show_thought("Time to hunt")
		queue_free()
	else:
		emit_signal("gunLine1")
