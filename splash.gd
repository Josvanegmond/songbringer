extends Control


@onready var tts_label = $PanelContainer/ToggleTTSLabel
var fade_in = true
var finish_fade = false


func _ready() -> void:
	if GameState.selected_voice:
		var tts_toggle_action_text = Helpers.get_input_action_as_text('toggle_text_to_speech', ' or ')
		var tts_skip_action_text = Helpers.get_input_action_as_text('skip_speech', ' or ')
		var tts_enabled = 'enabled' if GameState.tts_over_screenreader else 'disabled'
		tts_label.text = tts_label.text % [tts_enabled, tts_toggle_action_text, tts_skip_action_text]
		DisplayServer.tts_speak(tts_label.text, GameState.selected_voice)
	else:
		tts_label.text = 'Could not detect text-to-speech voice on your system.'


func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton || event is InputEventKey || event is InputEventMouseButton:
		fade_in = false
		TtsHelper.speak('')


func _process(delta: float) -> void:
	if !finish_fade:
		if fade_in && tts_label.modulate.a < 1:
			tts_label.modulate.a += delta
		else:
			tts_label.modulate.a -= delta
		
		if tts_label.modulate.a <= 0:
			finish_fade = true
	
	if finish_fade:
		get_parent().scene_finished.emit(self)
