extends VBoxContainer



func _on_ambient_slider_value_changed(value:float) -> void:
	GameState.ambient_volume = linear_to_db(value)


func _on_music_slider_value_changed(value:float) -> void:
	GameState.music_volume = linear_to_db(value)


func _on_master_slider_value_changed(value:float) -> void:
	GameState.master_volume = linear_to_db(value)


func _on_sound_slider_value_changed(value:float) -> void:
	GameState.sound_volume = linear_to_db(value)


func _on_tts_check_toggled(toggled_on:bool) -> void:
	GameState.tts_over_screenreader = toggled_on
