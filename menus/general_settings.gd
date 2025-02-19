extends VBoxContainer


func _ready() -> void:
	set_tts_check(GameState.tts_over_screenreader)
	GameState.on_toggle_tts_over_screenreader.connect(set_tts_check)


func set_tts_check(enabled):
	var tts_check_button: CheckButton = $TextSettings/TTSCheck
	if tts_check_button.button_pressed != enabled:
		tts_check_button.button_pressed = enabled


func _on_ambient_slider_value_changed(value:float) -> void:
	GameState.ambient_volume = linear_to_db(value)
	AudioServer.set_bus_volume_linear(1, value)


func _on_music_slider_value_changed(value:float) -> void:
	GameState.music_volume = linear_to_db(value)
	AudioServer.set_bus_volume_linear(2, value)


func _on_master_slider_value_changed(value:float) -> void:
	GameState.master_volume = linear_to_db(value)
	AudioServer.set_bus_volume_linear(0, value)


func _on_sound_slider_value_changed(value:float) -> void:
	GameState.sound_volume = linear_to_db(value)
	AudioServer.set_bus_volume_linear(3, value)


func _on_tts_check_toggled(toggled_on:bool) -> void:
	if toggled_on != GameState.tts_over_screenreader:
		GameState.toggle_tts_over_screenreader()
