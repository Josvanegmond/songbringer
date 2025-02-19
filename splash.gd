extends Control


@onready var tts_label = $PanelContainer/ToggleTTSLabel
var fade_in = true
var finish_fade = false


func _ready() -> void:
	if GameState.selected_voice:
		var tts_toggle_action_text = Helpers.get_input_action_as_text('toggle_text_to_speech', ' or ')
		var tts_enabled = 'enabled' if GameState.tts_over_screenreader else 'disabled'
		tts_label.text = tts_label.text % [tts_enabled, tts_toggle_action_text]
		DisplayServer.tts_speak(tts_label.text, GameState.selected_voice)
	else:
		tts_label.text = 'Could not detect text-to-speech voice on your system.'


func _input(event: InputEvent) -> void:
	if event.is_action_released('skip_speech'):
		finish_fade = true
		TtsHelper.speak('')


func _process(delta: float) -> void:
	if !finish_fade:
		if fade_in:
			tts_label.modulate.a += delta
			if tts_label.modulate.a >= 3:
				fade_in = false
		else:
			tts_label.modulate.a -= delta
		
		if tts_label.modulate.a <= 0:
			finish_fade = true
	
	if finish_fade:
		get_parent().scene_finished.emit(self)
