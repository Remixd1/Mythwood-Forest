extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")

const DETECTION_RANGE = 30
const MOVE_SPEED = 3.0


func _ready():
	anim_player.play("Idle")

func _physics_process(delta):
	if player == null:
		return
	
	var distance = global_position.distance_to(player.global_position)
	
	if distance <= DETECTION_RANGE:
		# Chase player
		if anim_player.current_animation != "Walk":
			anim_player.play("Walk")
			anim_player.speed_scale = 2.0  # double speed
		
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * MOVE_SPEED * delta
		
		# Face the player
		var target = global_position + direction
		look_at(target, Vector3.UP)
		rotate_y(deg_to_rad(90))
	else:
		# Return to idle
		if anim_player.current_animation != "Idle":
			anim_player.play("Idle")
