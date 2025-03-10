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

func _ready() -> void:
	finished.connect(next_sound)
	next_sound()


var sounds_played = 0
var crackle_playing = false
var opera_playing = false


func next_sound() -> void:
	opera_playing = false
	crackle_playing = false
	
	sounds_played += 1
	if sounds_played % 2 == 1:
			crackle_playing = true
			stream = crack_start
			await get_tree().create_timer(randf_range(1, 2)).timeout
			play()
			#await get_tree().create_timer(2 + (randi_range(1, 2))).timeout
			#stream = crack_start
			#crackle_playing = false
			#print("Crackle finished")
			#play()
	elif sounds_played >= 2:
		var opera_next = randi_range(2,8)
		if opera_next <= sounds_played:
			sounds_played = 0
			stream = opera_bits[randi_range(1, 11)]
			opera_playing = true
			play()
		else:
			stream = random_bits[randi_range(1, 9)]
			play()
