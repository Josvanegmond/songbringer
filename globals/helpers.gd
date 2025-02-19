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
	{ 'what': 'Joypad', 'by': 'Controler' },
	{ 'what': 'Button 0 ', 'by': 'bottom action|', 'discard_after': true },
	{ 'what': 'Button 1 ', 'by': 'right action|', 'discard_after': true },
	{ 'what': 'Button 2 ', 'by': 'left action|', 'discard_after': true },
	{ 'what': 'Button 3 ', 'by': 'top action|', 'discard_after': true },
	{ 'what': 'Button 4 ', 'by': 'back/select|', 'discard_after': true },
	{ 'what': 'Button 5 ', 'by': 'guide/home|', 'discard_after': true },
	{ 'what': 'Button 6 ', 'by': 'start/menu|', 'discard_after': true },
	{ 'what': 'Button 7 ', 'by': 'left stick press|', 'discard_after': true },
	{ 'what': 'Button 8 ', 'by': 'right stick press|', 'discard_after': true },
	{ 'what': 'Button 9 ', 'by': 'left shoulder|', 'discard_after': true },
	{ 'what': 'Button 10 ', 'by': 'right shoulder|', 'discard_after': true },
	{ 'what': 'Button 11 ', 'by': 'D-pad top|', 'discard_after': true },
	{ 'what': 'Button 12 ', 'by': 'D-pad bottom|', 'discard_after': true },
	{ 'what': 'Button 13 ', 'by': 'D-pad left|', 'discard_after': true },
	{ 'what': 'Button 14 ', 'by': 'D-pad right|', 'discard_after': true },

	{ 'what': 'Motion on Axis 0 - ', 'by': 'left stick left|', 'discard_after': true },
	{ 'what': 'Motion on Axis 0 + ', 'by': 'left stick right|', 'discard_after': true },
	{ 'what': 'Motion on Axis 1 - ', 'by': 'left stick up|', 'discard_after': true },
	{ 'what': 'Motion on Axis 1 + ', 'by': 'left stick down|', 'discard_after': true },
	{ 'what': 'Motion on Axis 2 - ', 'by': 'right stick left|', 'discard_after': true },
	{ 'what': 'Motion on Axis 2 + ', 'by': 'right stick right|', 'discard_after': true },
	{ 'what': 'Motion on Axis 3 - ', 'by': 'right stick up|', 'discard_after': true },
	{ 'what': 'Motion on Axis 3 + ', 'by': 'right stick down|', 'discard_after': true },
	{ 'what': 'Motion on Axis 4 + ', 'by': 'left trigger|', 'discard_after': true },
	{ 'what': 'Motion on Axis 5 + ', 'by': 'right trigger|', 'discard_after': true },
]

func format_input_action_text(input_action_text):
	for replace_line in replacers:
		input_action_text = input_action_text.replace(replace_line.what, replace_line.by)
		if replace_line.has('discard_after'):
			input_action_text = input_action_text.split('|')[0]
	return input_action_text
