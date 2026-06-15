extends CharacterBody3D


const SPEED = 4.5
const JUMP_VELOCITY = 3
const SENSITIVITY = 0.004


#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

var sprint_speed = 0
var gravity = 9.81
var step_timer := 0.0
var step_playing := false
var can_control := true

@onready var head = $Player
@onready var camera = $Player/Camera3D
@onready var ray = $Player/Camera3D/RayCast3D
@onready var interact_label = $CanvasLayer/InteractLabel
@onready var footstep_player = $FootstepsPlayer
@export var step_interval := 0.5  # seconds between steps


func _process(delta):
	if can_control:
		ray.force_raycast_update()
		if ray.is_colliding():
			var target = ray.get_collider()
			if target.has_method("collect"):
				# Show the item's custom label
				interact_label.visible = true
				interact_label.text = target.interact_text
		else:
			interact_label.visible = false
		#interact
		if Input.is_action_just_pressed("interact") and ray.is_colliding():
			var target = ray.get_collider()
			if target.has_method("collect"):
				target.collect()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$CanvasLayer.show_thought("Man what time is it? I'm Starving...")


func _unhandled_input(event):
	if can_control:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	if can_control:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta
		
		# Handle Sprint
		if Input.is_action_just_pressed("Sprint") and is_on_floor():
			sprint_speed = 2.5
		if Input.is_action_just_released("Sprint"):
			sprint_speed = 0

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("Right", "Left", "Backward", "Forward")
		var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var actual_speed = SPEED + sprint_speed
		if is_on_floor():
			if is_on_floor() and velocity.length() > 0.1:
				if not footstep_player.playing:
					footstep_player.play()
			else:
				if footstep_player.playing:
					footstep_player.stop()
			#movment
			if direction:
				velocity.x = direction.x * actual_speed
				velocity.z = direction.z * actual_speed
			else:
				velocity.x = 0.0
				velocity.z = 0.0
		else:
			velocity.x = lerp(velocity.x, direction.x * actual_speed, delta * 3.0)
			velocity.z = lerp(velocity.z, direction.z * actual_speed, delta * 3.0)

		move_and_slide()
