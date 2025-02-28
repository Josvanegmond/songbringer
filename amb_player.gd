extends AudioStreamPlayer


@export var amb_list: Array[AudioStream] = []

var name_to_index = {}
var current_amb = null


func _ready() -> void:
	for i in range(amb_list.size()):
		var amb: AudioStream = amb_list[i]
		var amb_parts = amb.resource_path.split('.')[0].split('/')
		var amb_name = amb_parts[amb_parts.size() - 1]
		name_to_index[amb_name] = i
	
	GameBus.handle_tag.connect(handle_tag)


func handle_tag(tag_command, tag_args):
	if tag_command == 'amb_play':
		transition_amb_to(tag_args[0])
		print("playing amb "+str(tag_args[0]))


func transition_amb_to(amb_name):
	if current_amb == amb_name:
		return

	if name_to_index.has(amb_name):
		var audio_stream: AudioStream = amb_list[name_to_index[amb_name]]
		current_amb = amb_name
		stream = audio_stream
		play()
	else:
		stop()
