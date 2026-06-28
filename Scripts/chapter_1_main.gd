extends Node3D

var tapesCollected := 0
const tapesRequired := 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CassetteTape1.connect("collected", Callable(self, "_on_tape_collected"))
	$CassetteTape2.connect("collected", Callable(self, "_on_tape_collected"))
	$CassetteTape3.connect("collected", Callable(self, "_on_tape_collected"))
	$Key.connect("collected", Callable(self, "_on_key_collected"))

func _on_tape_collected():
	tapesCollected += 1
	if tapesCollected >= tapesRequired:
		$Key.can_pickup = true
		# show hint to player

# func _on_key_collected():
	# unlock exit, trigger next scene etc
