extends StaticBody3D

@export var item_name := "Door"
@export var interact_text := "Door"
var collected := false
var can_pickup := true

func collect():
	if collected:
		return
	if can_pickup:
		collected = true
		var sfx = AudioStreamPlayer3D.new()
		sfx.stream = $OpenSound.stream
		get_parent().add_child(sfx)
		sfx.play()
		await get_tree().create_timer(sfx.stream.get_length()).timeout
		sfx.queue_free()
	
		print("Opened:", item_name)
		var fade_layer = $"../Transition/fadeLayer"
		fade_layer.fade_and_change_scene("res://Scenes/forestT.tscn")




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
