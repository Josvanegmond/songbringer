extends VBoxContainer

var key_bind_row_tscn = preload('res://menus/key_bind_row.tscn')

@onready var key_bindings: VBoxContainer = $KeyBindings

var rebind_key = null
var default_keybinds = {}


func _ready() -> void:
	var actions = ['left', 'right', 'interact', 'repeat_text']
	
	for action in actions:
		var key_bind_row = key_bind_row_tscn.instantiate()

		var action_label = key_bind_row.get_node('ActionLabel')
		action_label.text = action

		var action_keys_label = key_bind_row.get_node('ActionKeysLabel')
		var action_list = InputMap.action_get_events(action)
		default_keybinds[action] = action_list
		for input_event in action_list:
			action_keys_label.text += input_event.as_text() + '\n'

		var override_button: Button = key_bind_row.get_node('OverrideButton')
		override_button.pressed.connect(func(): rebind_key = key_bind_row)

		var reset_button: Button = key_bind_row.get_node('ResetButton')
		reset_button.pressed.connect(func(): reset_bindings(key_bind_row))

		key_bindings.add_child(key_bind_row)


func _input(event):
	if rebind_key:
		var override_button = rebind_key.get_node('OverrideButton')
		var ignore = event is InputEventMouseMotion || event is InputEventMouseButton || event.is_action_pressed('ui_cancel')
		if !ignore:
			override_button.text = 'listening for input...'
			var action = rebind_key.get_node('ActionLabel').text
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)

			rebind_key.get_node('ActionKeysLabel').text = event.as_text()
			override_button.text = 'Override'
			rebind_key = null
		
		if event.is_action_pressed('ui_cancel'):
			override_button.text = 'Override'
			rebind_key = null


func reset_bindings(key_bind_row):
	var action = key_bind_row.get_node('ActionLabel').text
	InputMap.action_erase_events(action)

	var actions_label = key_bind_row.get_node('ActionKeysLabel')
	actions_label.text = ''
	for event in default_keybinds[action]:
		InputMap.action_add_event(action, event)
		actions_label.text += event.as_text() + '\n'

	
