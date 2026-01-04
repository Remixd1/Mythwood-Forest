extends StaticBody3D

@export var item_name := "Camera"
@export var interact_text := "Camera"
var collected := false
var can_pickup := false
signal cameraLine1
signal cameraGet

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
		emit_signal("cameraGet")
		$"../CharacterBody3D/CanvasLayer".show_thought("Hopefully I can record something")
		queue_free()
	else:
		emit_signal("cameraLine1")
