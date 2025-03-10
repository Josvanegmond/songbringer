extends AudioStreamPlayer3D


var random_bits = [
	preload('res://game_sounds/grammaphone/randombits/1.ogg'),
	preload('res://game_sounds/grammaphone/randombits/2.ogg'),
	preload('res://game_sounds/grammaphone/randombits/3.ogg'),
	preload('res://game_sounds/grammaphone/randombits/4.ogg'),
	preload('res://game_sounds/grammaphone/randombits/5.ogg'),
	preload('res://game_sounds/grammaphone/randombits/6.ogg'),
	preload('res://game_sounds/grammaphone/randombits/7.ogg'),
	preload('res://game_sounds/grammaphone/randombits/8.ogg'),
	preload('res://game_sounds/grammaphone/randombits/9.ogg'),
	preload('res://game_sounds/grammaphone/randombits/10.ogg'),
]

var opera_bits = [
	preload('res://game_sounds/grammaphone/operabits/1.ogg'),
	preload('res://game_sounds/grammaphone/operabits/2.ogg'),
	preload('res://game_sounds/grammaphone/operabits/3.ogg'),
	preload('res://game_sounds/grammaphone/operabits/4.ogg'),
	preload('res://game_sounds/grammaphone/operabits/5.ogg'),
	preload('res://game_sounds/grammaphone/operabits/6.ogg'),
	preload('res://game_sounds/grammaphone/operabits/7.ogg'),
	preload('res://game_sounds/grammaphone/operabits/8.ogg'),
	preload('res://game_sounds/grammaphone/operabits/9.ogg'),
	preload('res://game_sounds/grammaphone/operabits/10.ogg'),
	preload('res://game_sounds/grammaphone/operabits/11.ogg'),
	preload('res://game_sounds/grammaphone/operabits/12.ogg'),
]

var crack_start = preload('res://game_sounds/grammaphone/crack start.ogg')

var casta_diva = preload("res://game_sounds/grammaphone/Bellini_Casta_diva_par_Claudia_Muzio.ogg")


func _ready() -> void:
	finished.connect(next_sound)
	GameBus.handle_tag.connect(handle_tag)
	next_sound()


var gramophone_solved = false
var sounds_played = 0
var crackle_playing = false
var opera_playing = false

signal gramophone_song(snippet: String)


func next_sound() -> void:
	opera_playing = false
	crackle_playing = false
	
	if not gramophone_solved:
		sounds_played += 1
		if sounds_played % 2 == 1:
				gramophone_song.emit("crackle")
				crackle_playing = true
				stream = crack_start
				await get_tree().create_timer(randf_range(1, 2)).timeout
				if not gramophone_solved:
					play()
				#await get_tree().create_timer(2 + (randi_range(1, 2))).timeout
				#stream = crack_start
				#crackle_playing = false
				#print("Crackle finished")
				#play()
		elif sounds_played >= 2:
			var opera_next = randi_range(2,8)
			if opera_next <= sounds_played:
				gramophone_song.emit("opera")
				sounds_played = 0
				stream = opera_bits[randi_range(1, 11)]
				opera_playing = true
				play()
			else:
				gramophone_song.emit("other")
				stream = random_bits[randi_range(1, 9)]
				play()

func handle_tag(tag_command, tag_args):
	if tag_command == 'snippet' and tag_args[0] == "complete":
		gramophone_solved = true
		stop()
		stream = casta_diva
		play()
		
