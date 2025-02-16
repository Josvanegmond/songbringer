extends AudioStreamPlayer


@export var music_list: Array[AudioStream] = []

var name_to_index = {}

func _ready() -> void:
	for i in range(music_list.size()):
		var song: AudioStream = music_list[i]
		var song_parts = song.resource_path.split('.')[0].split('/')
		var song_name = song_parts[song_parts.size() - 1]
		name_to_index[song_name] = i
	
	GameBus.handle_tag.connect(handle_tag)


func handle_tag(tag_parts):
	print(tag_parts)
	if tag_parts[0] == 'music_play':
		transition_music_to(tag_parts[1])


func transition_music_to(song_name):
	var audio_stream: AudioStream = music_list[name_to_index[song_name]]

	stream = audio_stream
	play()
