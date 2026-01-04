extends Node3D

var dialogue = [
	{"speaker": "Jason", "text": "Hello?", "voice": preload("res://Sound and music/VoiceLines/line1.wav")},
	{"speaker": "Sam", "text": "It’s me, I got another job for you, its a bit odd but right up your alley", "voice": preload("res://Sound and music/EatingSFX.wav")},
	{"speaker": "Jason", "text": "Spit it out", "voice": preload("res://Sound and music/VoiceLines/line3.wav")},
	{"speaker": "Sam", "text": "Hold your horses I'm getting there", "voice": preload("res://Sound and music/EatingSFX.wav")},
	{"speaker": "Sam", "text": "There’s been reports and rumors circling this new creepy forest, internet calls it mythwoods or something", "voice": preload("res://Sound and music/EatingSFX.wav")},
	{"speaker": "Sam", "text": "Witnesses report hearing voices and seeing shadows. You know, all the usual psycho crap, could just be a bunch of bull, but I figured I’d let you know Mr. “Monster Hunter”", "voice": preload("res://Sound and music/EatingSFX.wav")},
	{"speaker": "Jason", "text": "Tell me more...", "voice": preload("res://Sound and music/VoiceLines/line7.wav")},
	{"speaker": "Sam", "text": "Its not far from you, ‘bout 2 Hours,  reckon you could finally get your major breakthrough with this one, even though the tip aint much", "voice": preload("res://Sound and music/EatingSFX.wav")},
	{"speaker": "Jason", "text": "Alright, I'll check it out, thanks", "voice": preload("res://Sound and music/VoiceLines/line9.wav")},
	{"speaker": "Sam", "text": "Don't mention it, just don’t forget about your little ol’ monster scout when you drag bigfoot's head outta the forest", "voice": preload("res://Sound and music/EatingSFX.wav")},
]

var dialogue_index = 0
var in_dialogue = false
signal callFinished

@onready var voice_player = $"../../CharacterBody3D/CanvasLayer2/DialogBox/VoicePlayer"
@onready var dialogue_box = $"../../CharacterBody3D/CanvasLayer2/DialogBox"
@onready var player = $"../../CharacterBody3D"

func start_dialogue():
	dialogue_index = 0
	in_dialogue = true
	player.can_control = false
	show_line()

func show_line():
	if dialogue_index >= dialogue.size():
		end_dialogue()
		return
	
	var line = dialogue[dialogue_index]
	dialogue_box.show_line(line["speaker"], line["text"])
	voice_player.stream = line["voice"]
	voice_player.play()

func _input(event):
	if in_dialogue and event.is_action_pressed("next_line"):
		if dialogue_box.typing:
			dialogue_box.skip_typing()
		elif voice_player.playing:
			voice_player.stop()
			dialogue_index += 1
			show_line()
		else:
			dialogue_index += 1
			show_line()

func end_dialogue():
	in_dialogue = false
	dialogue_box.hide_box()
	player.can_control = true
	print("Dialogue finished")
	emit_signal("callFinished") 
