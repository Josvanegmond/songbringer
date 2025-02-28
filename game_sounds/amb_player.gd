extends AudioStreamPlayer


@export var music_list: Array[AudioStream] = []

var name_to_index = {}
var current_song = null


func _ready() -> void:
	for i in range(music_list.size()):
		var song: AudioStream = music_list[i]
		var song_parts = song.resource_path.split('.')[0].split('/')
		var song_name = song_parts[song_parts.size() - 1]
		name_to_index[song_name] = i
	
	GameBus.handle_tag.connect(handle_tag)


func handle_tag(tag_command, tag_args):
	if tag_command == 'ambience_play':
		transition_music_to(tag_args[0])
		print("ambience switched to "+tag_args[0])



func transition_music_to(song_name):
	if current_song == song_name:
		return

	if name_to_index.has(song_name):
		var audio_stream: AudioStream = music_list[name_to_index[song_name]]
		current_song = song_name
		stream = audio_stream
		play()
	else:
		stop()
