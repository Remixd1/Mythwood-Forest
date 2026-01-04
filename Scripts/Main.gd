extends Node3D

var itemCounter := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var canvas_layer = $CharacterBody3D/CanvasLayer
	$Cereal.connect("collected", Callable(self, "_on_cereal_collected"))
	$Phone.connect("phone_answered", Callable(self, "_on_phone_answered"))
	$Rifle.connect("gunLine1", Callable(self, "cannotPickup_gun"))
	$BeerCans.connect("beerLine1", Callable(self, "cannotPickup_beer"))
	$Anitbiotics.connect("pillsLine1", Callable(self, "cannotPickup_pills"))
	$Camera.connect("cameraLine1", Callable(self, "cannotPickup_camera"))
	$Flashlight.connect("flashlightLine1", Callable(self, "cannotPickup_flashlight"))
	$Phone/phoneDialog.connect("callFinished", Callable(self, "showChecklist"))
	$RainBG.play()
	
	#packing list trackers
	$Rifle.connect("gunGet", Callable(self, "timeToGo"))
	$BeerCans.connect("beerGet", Callable(self, "timeToGo"))
	$Anitbiotics.connect("pillsGet", Callable(self, "timeToGo"))
	$Camera.connect("cameraGet", Callable(self, "timeToGo"))
	$Flashlight.connect("flashLightGet", Callable(self, "timeToGo"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Item Handlers----------------------------	
func _on_cereal_collected():
	$CharacterBody3D/CanvasLayer.show_thought("This will have to do")

	await get_tree().create_timer(5.0).timeout
	$CharacterBody3D/CanvasLayer.show_thought("Who's Calling at this hour?")
	$Phone.start_ringing()
	
func _on_phone_answered():
	$Rifle.can_pickup = true
	$BeerCans.can_pickup = true
	$Anitbiotics.can_pickup = true
	$Camera.can_pickup = true
	$Flashlight.can_pickup = true
	
	$Phone/phoneDialog.start_dialogue()
	$CharacterBody3D/CanvasLayer.clear_thought()

func cannotPickup_gun():
	$CharacterBody3D/CanvasLayer.show_thought("My hunting rifle...")

func cannotPickup_beer():
	$CharacterBody3D/CanvasLayer.show_thought("Don't feel like drinking right now...")

func cannotPickup_pills():
	$CharacterBody3D/CanvasLayer.show_thought("Painkillers...")

func cannotPickup_camera():
	$CharacterBody3D/CanvasLayer.show_thought("Still trying to get a picture of a monster...")

func cannotPickup_flashlight():
	$CharacterBody3D/CanvasLayer.show_thought("Just a flashlight...")

func showChecklist():
	$CharacterBody3D/CanvasLayer.show_thought("I should probably pack my stuff")
	$CharacterBody3D/CanvasLayer/packList.show_list()

func timeToGo():
	itemCounter += 1
	if itemCounter >= 5:
		await get_tree().create_timer(3.0).timeout
		$CharacterBody3D/CanvasLayer.show_thought("Alright its time to go")
		$CharacterBody3D/CanvasLayer/packList.hide_list()
		$Door.can_pickup = true
	
