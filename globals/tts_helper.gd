extends Node


func speak(speech: String):
	DisplayServer.tts_stop()
	if GameState.selected_voice && GameState.tts_over_screenreader:
		DisplayServer.tts_speak(speech, GameState.selected_voice, int(GameState.tts_volume), GameState.tts_rate, 1.0, 0, true)


func stop_speak():
	DisplayServer.tts_stop()