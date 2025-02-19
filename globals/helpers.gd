extends Node

func get_input_action_as_text(input_action, joiner = ', '):
	var tts_toggle_actions = InputMap.action_get_events(input_action).map(
		func(input):
			var as_text = input.as_text()
			return format_input_action_text(as_text)
	)
	return joiner.join(tts_toggle_actions)


var replacers = [
	{ 'what': ' (Physical)', 'by': '' },
	{ 'what': ' with Value -1.00', 'by': '' },
	{ 'what': ' with Value 1.00', 'by': '' },
	{ 'what': ' Joypad', 'by': 'Controler' },
]

func format_input_action_text(input_action_text):
	for replace_line in replacers:
		input_action_text = input_action_text.replace(replace_line.what, replace_line.by)
	return input_action_text
