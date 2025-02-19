extends Control


@export var has_started = false

@onready var start_game_button = $MenuPanel/MarginContainer/VBoxContainer/StartGameButton
@onready var continue_game_button = $MenuPanel/MarginContainer/VBoxContainer/ContinueGameButton


func _ready() -> void:
	set_started(has_started)
	set_focus()
	update_music()


func _input(event: InputEvent) -> void:
	if visible && event.is_action_pressed("main_menu"):
		accept_event()
		toggle()


func toggle():
	visible = !visible
	GameState.paused = visible
	if visible:
		set_focus()


func options_closed():
	$MenuPanel.visible = true
	set_focus()


func set_focus():
	if start_game_button.visible:
		start_game_button.grab_focus()
	else:
		continue_game_button.grab_focus()


func set_started(started):
	has_started = started
	update_music()
	start_game_button.visible = !has_started
	continue_game_button.visible = has_started


func update_music():
	var music_player: AudioStreamPlayer = $MainMusicPlayer
	if has_started:
		music_player.stop()
	else:
		music_player.play()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	$MenuPanel.visible = false
	$Options.toggle()


func _on_start_game_button_pressed() -> void:
	set_started(true)

	get_parent().scene_finished.emit(self)


func _on_continue_game_button_pressed() -> void:
	toggle()
