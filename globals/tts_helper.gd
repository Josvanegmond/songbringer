extends Node


func speak(speech: String):
	DisplayServer.tts_stop()
	if GameState.selected_voice && GameState.tts_over_screenreader:
		DisplayServer.tts_speak(speech, GameState.selected_voice, 50, 1.0, 1.0, 0, true)