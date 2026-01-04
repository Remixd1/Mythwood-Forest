extends StaticBody3D

@export var item_name := "Flashlight"
@export var interact_text := "Flashlight"
var collected := false
var can_pickup := false
signal flashlightLine1
signal flashLightGet

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
		emit_signal("flashLightGet")
		$"../CharacterBody3D/CanvasLayer".show_thought("Definitely need this")
		print("Collected:", item_name)
		
		queue_free()
	else:
		emit_signal("flashlightLine1")
