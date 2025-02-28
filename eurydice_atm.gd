extends AudioStreamPlayer

func _ready() -> void:
	GameBus.handle_tag.connect(handle_tag)

var ship_atm_playing = false

func handle_tag(tag_command, tag_args):
	if tag_command == 'amb_ship_play': 
		if tag_args[0] == "eurydiceatmloop":
			if ship_atm_playing == false:
				play()
				print("playing eurydice background atm")
				ship_atm_playing = true
		else:
			stop()
			print("stopping eurydice background atm")
			print("potential error: eurydice atm loop paused, due to receiving " + tag_args[0] + "instead of expected eurydiceatmloop. If this was intentionally used to pause ambiance, ignore error")
			ship_atm_playing = false
