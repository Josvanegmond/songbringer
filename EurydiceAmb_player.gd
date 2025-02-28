extends AudioStreamPlayer

var eurydice_amb_playing = false

func _ready() -> void:
	GameBus.handle_tag.connect(handle_tag)


func handle_tag(tag_command, tag_args):
	if tag_command == 'amb_play_eurydice':
		if tag_args[0] == "on":
			if eurydice_amb_playing == true:
				return
			else:
				play()
				eurydice_amb_playing = true
		elif tag_args[0] == "off":
			stop()
			eurydice_amb_playing = false
		else:
			print("potential error toggling eurydice ambiance; expected on/off, recieved " + str(tag_args[0]))
