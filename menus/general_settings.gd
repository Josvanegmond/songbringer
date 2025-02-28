extends VBoxContainer


func _ready() -> void:
	GameState.on_toggle_tts_over_screenreader.connect(set_tts_check)


func update_content():
	$SoundSettings/AmbientSlider.value = db_to_linear(GameState.ambient_volume)
	$SoundSettings/MusicSlider.value = db_to_linear(GameState.music_volume)
	$SoundSettings/SoundSlider.value = db_to_linear(GameState.sound_volume)
	$SoundSettings/MasterSlider.value = db_to_linear(GameState.master_volume)
	$SoundSettings/TTSSlider.value = GameState.tts_volume
	set_tts_check(GameState.tts_over_screenreader)


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


func _on_tts_slider_value_changed(value:float) -> void:
	GameState.tts_volume = value


func _on_tts_check_toggled(toggled_on:bool) -> void:
	if toggled_on != GameState.tts_over_screenreader:
		GameState.toggle_tts_over_screenreader()
