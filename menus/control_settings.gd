extends VBoxContainer

var key_bind_row_tscn = preload('res://menus/key_bind_row.tscn')

@onready var key_bindings: VBoxContainer = $KeyBindings

var rebind_key = null
var default_keybinds = {}

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
			rebind_key.get_node('ActionKeysLabel').text = 'listening for input...'
		)

		var reset_button: Button = key_bind_row.get_node('ResetButton')
		reset_button.pressed.connect(func(): reset_bindings(key_bind_row))

		key_bindings.add_child(row_scene)


func _input(event):
	if GameState.key_rebinding && rebind_key:
		accept_event()
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

	
func _on_reset_all_button_pressed() -> void:
	for key_bind_row in key_bindings.get_children():
		reset_bindings(key_bind_row)
