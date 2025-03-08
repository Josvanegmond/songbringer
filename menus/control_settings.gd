extends VBoxContainer

var key_bind_row_tscn = preload('res://menus/key_bind_row.tscn')

@onready var key_bindings: VBoxContainer = $KeyBindings

var rebind_key = null
var default_keybinds = {}
var menu

var actions = [
	'left', 
	'right', 
	'interact', 
	'repeat_text',
	'toggle_text_to_speech',
	'skip_speech',
	'next_tab',
	'previous_tab',
]


func _ready() -> void:
	menu = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()
	for action in actions:
		var row_scene = key_bind_row_tscn.instantiate()
		var key_bind_row = row_scene.get_node('KeyBindRow')

		var action_label = key_bind_row.get_node('ActionLabel')
		action_label.text = action

		var action_keys_label = key_bind_row.get_node('ActionKeysLabel')
		var action_list = InputMap.action_get_events(action)
		default_keybinds[action] = action_list

		action_keys_label.text = '\n'.join(action_list.map(
			func(input_event):
				return Helpers.format_input_action_text(input_event.as_text())
		))

		var override_button: Button = key_bind_row.get_node('OverrideButton')
		override_button.pressed.connect(func():
			GameState.key_rebinding = true
			rebind_key = key_bind_row
			menu.play_click()
			rebind_key.get_node('ActionKeysLabel').text = 'listening for input...'
			TtsHelper.speak("listening for input for "+str(action))
		)

		var alt_text = ("Override " + str(action) + " control from current input, navigate right to hear or reset to default inputs")
		override_button.focus_entered.connect(func():
			menu.play_hover()
			TtsHelper.speak(alt_text)
			)

		var reset_button: Button = key_bind_row.get_node('ResetButton')
		reset_button.pressed.connect(func(): reset_bindings(key_bind_row))
		
		var alt_text_reset = ("Reset " + str(action) + "control to the following default inputs, or navigate left to override: " + '\n'.join(action_list.map(
			func(input_event):
				return Helpers.format_input_action_text(input_event.as_text())
				)))
		reset_button.focus_entered.connect(func():
			menu.play_hover()
			TtsHelper.speak(alt_text_reset)
			)
		key_bindings.add_child(row_scene)
		# forgive me father for the following sin - needed to get click/hover players from menu scene
		
	


func _input(event):
	if GameState.key_rebinding && rebind_key:
		accept_event()
		menu.play_click()
		var override_button = rebind_key.get_node('OverrideButton')
		

		var ignore = (
			event is InputEventMouseMotion || 
			event is InputEventMouseButton ||
			event.is_action_pressed('ui_cancel') ||
			(event is InputEventJoypadMotion && abs(event.axis_value) < 1)
		)
		
		if !ignore:
			var action = rebind_key.get_node('ActionLabel').text
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)

			rebind_key.get_node('ActionKeysLabel').text = Helpers.format_input_action_text(event.as_text())
			rebind_key = null
			TtsHelper.speak(str(action) + " bound to " + str(event.as_text_key_label()))
		
		if event.is_action_pressed('ui_cancel'):
			override_button.text = 'Override'
			rebind_key = null
			GameState.key_rebinding = false


func reset_bindings(key_bind_row):

	var action = key_bind_row.get_node('ActionLabel').text
	InputMap.action_erase_events(action)

	var actions_label = key_bind_row.get_node('ActionKeysLabel')
	actions_label.text = ''
	var new_action_label_texts = []
	for event in default_keybinds[action]:
		InputMap.action_add_event(action, event)
		new_action_label_texts.append(Helpers.format_input_action_text(event.as_text()))
	actions_label.text = '\n'.join(new_action_label_texts)
	menu.play_click()
	TtsHelper.speak(str(action) + " reset to " + str(", ".join(new_action_label_texts)))

	
func _on_reset_all_button_pressed() -> void:
	for key_bind_row in key_bindings.get_children():
		reset_bindings(key_bind_row)
	menu.play_click()


func _on_reset_all_button_focus_entered() -> void:
	menu.play_hover()
