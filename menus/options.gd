extends Control


@onready var setting_tab_buttons = [
	$Panel/MarginContainer/VBoxContainer/HBoxContainer/GeneralSettingsButton,
	$Panel/MarginContainer/VBoxContainer/HBoxContainer/ControlSettingsButton
]

@onready var setting_tabs = [
	$Panel/MarginContainer/VBoxContainer/ScrollContainer/GeneralSettings,
	$Panel/MarginContainer/VBoxContainer/ScrollContainer/ControlSettings
]
var current_tab_index = 0


func _input(event: InputEvent) -> void:
	if GameState.key_rebinding: return

	if event.is_action_pressed('next_tab'):
		cycle_tabs(true)
	if event.is_action_pressed('previous_tab'):
		cycle_tabs(false)


func cycle_tabs(forward: bool):
	if forward:
		current_tab_index += 1
		current_tab_index %= setting_tabs.size()
	else:
		current_tab_index -= 1
		if current_tab_index < 0: current_tab_index = setting_tabs.size() - 1
		
	switch_to(current_tab_index)


func _on_general_settings_button_pressed() -> void:
	switch_to(0)


func _on_control_settings_button_pressed() -> void:
	switch_to(1)


func switch_to(setting_tab_index):
	current_tab_index = setting_tab_index
	var settings = setting_tabs[current_tab_index]

	for tab in setting_tabs:
		tab.visible = settings == tab

	setting_tab_buttons[current_tab_index].grab_focus()


func toggle():
	visible = !visible
	GameState.paused = visible

	if visible:
		setting_tab_buttons[current_tab_index].grab_focus()


func _on_close_button_pressed() -> void:
	toggle()
