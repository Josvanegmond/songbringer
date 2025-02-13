extends Node


@export var story: InkStory


# @onready var _ink_player = $InkPlayer
var subtitles = null


func _ready():
	await get_tree().create_timer(1).timeout
	GameBus.player_enters.connect(_pick_entrance_choice)
	continue_story()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("repeat_text"):
		print('reactivating live area')
		read_text(subtitles.text + "")


func continue_story():
	story.ContinueMaximally()
	var text = story.GetCurrentText()
	var tags = story.GetCurrentTags()
	print('continued: ', text, tags)
	read_text(text)



func read_text(text):
	var children = $VBox.get_children()
	for child in children:
		$VBox.remove_child(child)
	
	subtitles = Label.new()

	if 'accessibility_name' in subtitles:
		subtitles.accessibility_name = 'narration_text'

	subtitles.text = text
	subtitles.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$VBox.add_child(subtitles)
	subtitles.grab_focus()


func _ended():
	print("The End")


func _select_choice(index):
	story.ChooseChoiceIndex(index)
	continue_story()


func _pick_entrance_choice(entrance_name: String):
	print('looking for ', entrance_name)
	var current_choices: Array[InkChoice] = story.GetCurrentChoices()
	var choice_index = current_choices.find_custom(
		func (choice: InkChoice):
			var choice_tags = choice.GetTags()
			print('choice tags ', choice_tags)
			for tag in choice_tags:
				var tag_parts = tag.split(' ')
				return tag_parts.size() == 2 && tag_parts[0] == 'entrance_to' && tag_parts[1] == entrance_name
			return false
	)

	if choice_index >= 0:
		_select_choice(choice_index)
