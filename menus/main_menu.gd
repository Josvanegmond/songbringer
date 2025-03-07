extends Control


@export var has_started = false

@onready var start_game_button = $MenuPanel/MarginContainer/VBoxContainer/StartGameButton

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	get_viewport().gui_focus_changed.connect(focus_changed)
	set_started(has_started)
	set_focus()
	update_music()

func focus_changed(node: Control):
	if !visible: return
	if !node.has_focus(): return

	if node is Label: return # will be handled by subtitles

	var text = ''
	if node is Button: 
		text = node.text
		if "override" in node.text:
			return
		if "reset" in node.text:
			return
	if text == '': text = node.get_tooltip()
	#following buttons handled more granularly in control_settings
	TtsHelper.speak(text)


func _input(event: InputEvent) -> void:
	if visible && event.is_action_pressed("main_menu"):
		accept_event()
		toggle()


func toggle():
	if has_started:
		start_game_button.text = 'Continue'
	else:
		start_game_button.text = 'Start game'
		
	visible = !visible

	GameState.paused = visible
	if visible:
		set_focus()
		$Options/Panel/MarginContainer/VBoxContainer/ScrollContainer/GeneralSettings.update_content()


func options_closed():
	$MenuPanel.visible = true
	set_focus()


func set_focus():
	start_game_button.grab_focus()


func set_started(started):
	has_started = started
	update_music()


func update_music():
	var music_player: AudioStreamPlayer = $MainMusicPlayer
	if has_started:
		music_player.stop()
	else:
		music_player.play()


func _on_quit_button_pressed() -> void:
	play_click()
	get_tree().quit()


func _on_options_button_pressed() -> void:
	play_click()
	$MenuPanel.visible = false
	$Options.toggle()


func _on_start_game_button_pressed() -> void:
	play_click()
	if has_started:
		toggle()

	else:
		set_started(true)
		visible = false
		get_parent().scene_finished.emit(self)

func play_click():
	$ClickPlayer.set_pitch_scale(rng.randf_range(.85, 1.1))
	$HoverPlayer.set_volume_db(rng.randf_range(2, 8))
	$ClickPlayer.play()
	
func play_hover():
	$HoverPlayer.set_pitch_scale(rng.randf_range(.85, 1.1))
	$HoverPlayer.set_volume_db(rng.randf_range(-4, 2))
	$HoverPlayer.play()

func _on_start_game_button_focus_entered() -> void:
	play_hover()

func _on_options_button_focus_entered() -> void:
	play_hover()

func _on_quit_button_focus_entered() -> void:
	play_hover()
