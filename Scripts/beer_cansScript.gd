extends StaticBody3D

@export var item_name := "BeerCans"
@export var interact_text := "Beers"
var collected := false
var can_pickup := false
signal beerLine1
signal beerGet

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
		emit_signal("beerGet")
		$"../CharacterBody3D/CanvasLayer".show_thought("Something to take the edge off")
		queue_free()
	else:
		emit_signal("beerLine1")
