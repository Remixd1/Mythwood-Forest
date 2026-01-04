extends StaticBody3D

@export var item_name := "Phone"
@export var interact_text := "Phone"
var collected := false
var can_interact := false
var is_ringing := false
signal phone_answered

func start_ringing():
	can_interact = true
	is_ringing = true
	$RingingSound.play()
	
	
func collect():
	if can_interact:
		$RingingSound.stop()
		is_ringing = false
		$AnswerSound.play()
		can_interact = false
		emit_signal("phone_answered")
		print("Picked up the phone!")  # later you can trigger dialogue here
		
func _process(delta):
	if is_ringing and not $RingingSound.playing:
		$RingingSound.play()
