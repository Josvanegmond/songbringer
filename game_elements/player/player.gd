extends CharacterBody3D


var move_speed = 1.0
var acceleration = 4

var _gravity := -10.0

var can_enter_to_position = null
var can_enter_to_name = null

var moving_in_progress = false
var footstep_cooldown = false

var freeze = false

var music_bus = AudioServer.get_bus_index("Music")

@export var play_sounds: Array[AudioStream] = []
@onready var sound_player: AudioStreamPlayer = $SoundPlayer


func _ready() -> void:
	GameBus.player_can_enter_to.connect(_can_enter_to)
	GameBus.player_cant_enter.connect(_cant_enter_to)
	GameBus.handle_tag.connect(handle_tag)
	GameBus.etherphone.connect(_on_etherphone)
	GameBus.change_footstep.connect(set_footstep_type)


func _physics_process(delta: float) -> void:
	if GameState.paused || moving_in_progress || freeze: return

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

	handle_moving_animation(velocity, delta)


func handle_moving_animation(move_velocity, _delta):
	if abs(move_velocity.x) > 0:
		$AnimatedSprite3D.play('walking')
		$AnimatedSprite3D.flip_h = move_velocity.x > 0

		if $AnimatedSprite3D.frame == 1 && !footstep_cooldown:
			$FootstepsBootRandom.play()
			footstep_cooldown = true
		if $AnimatedSprite3D.frame != 1:
			footstep_cooldown = false
	else:
		$AnimatedSprite3D.play('standing')

func set_footstep_type(footstep_type):
	if footstep_type is AudioStreamRandomizer:
		$FootstepsBootRandom.set_stream(footstep_type)
	else:
		$FootstepsBootRandom.set_stream(load("res://sounds/footsteps/footsteps_boot_random.tres"))

func _can_enter_to(pos: Vector3, choice_name, door_type):
	can_enter_to_position = pos
	can_enter_to_name = choice_name
	print("door type is set to " + str(door_type))
	if $EnterAudio.get_stream() != door_type:
		$EnterAudio.set_stream(door_type)


func _cant_enter_to():
	can_enter_to_position = null
	can_enter_to_name = null


func handle_tag(tag_command, tag_args):
	if tag_command == 'player':
		if tag_args[0] == 'freeze':
			freeze = true
			$AnimatedSprite3D.play('standing')
		if tag_args[0] == 'unfreeze':
			freeze = false
		
	if tag_command == 'player_sound':
		print(tag_args[0])
		for sound: AudioStream in play_sounds:
			var path_split = sound.resource_path.split('/')
			var sound_name = path_split[path_split.size() - 1]
			print(path_split, sound_name)
			if sound_name == tag_args[0]:
				var music_db_current = AudioServer.get_bus_volume_db(music_bus)
				print("music_db_current is " + str(music_db_current))
				if "shard" in tag_args[0]:
					AudioServer.set_bus_volume_db(music_bus, music_db_current - 15)
					print("reducing volume for shard to " + str(AudioServer.get_bus_volume_db(music_bus)))

				sound_player.stream = sound
				sound_player.play()
				if "shard" in tag_args[0]:
					await get_tree().create_timer(5).timeout
					AudioServer.set_bus_volume_db(music_bus, music_db_current)
					print("music volume restored")
				return

func _on_etherphone():
	print("attempting to play etherphone sound")
	sound_player.stream = play_sounds[0]
	sound_player.play()
