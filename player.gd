extends CharacterBody3D


var move_speed := 1.0
var acceleration := 4

var _gravity := -10.0

var can_enter_to_position = null
var can_enter_to_name = null

var moving_in_progress = false
var footstep_cooldown = 0


func _ready() -> void:
	GameBus.player_can_enter_to.connect(_can_enter_to)
	GameBus.player_cant_enter.connect(_cant_enter_to)


func _physics_process(delta: float) -> void:
	if moving_in_progress: return

	handle_entering()
	handle_moving(delta)


func handle_entering():
	if can_enter_to_position != null && Input.is_action_just_pressed('interact'):
		moving_in_progress = true
		var prev_pos = position

		GameBus.player_enters.emit(can_enter_to_name)
		$EnterAudio.play()

		await get_tree().create_tween().tween_property(self, 'position', can_enter_to_position, 1).finished

		can_enter_to_position = prev_pos
		moving_in_progress = false



func handle_moving(delta: float):
	var raw_input =	Input.get_axis("left", "right")
	var move_vector = Vector3(raw_input, 0.0, 0.0).normalized()

	velocity = velocity.move_toward(move_vector * move_speed, acceleration * delta)

	var falling_speed = _gravity
	velocity.y = velocity.y + falling_speed * delta

	move_and_slide()

	if velocity.length() > 0 && footstep_cooldown <= 0:
		$FootstepsBootRandom.play()
		footstep_cooldown = 1
	
	if footstep_cooldown > 0:
		footstep_cooldown -= delta * velocity.length() * 3



func _can_enter_to(pos: Vector3, choice_name):
	can_enter_to_position = pos
	can_enter_to_name = choice_name


func _cant_enter_to():
	can_enter_to_position = null
	can_enter_to_name = null
