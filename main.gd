extends Node


@export var story: InkStory:
	get():
		return GameState.story
	set(_story):
		GameState.story = _story


var subtitles = null


func _ready():
	GameBus.select_choice.connect(_select_choice)
	continue_story()


func _input(event) -> void:
	if event.is_action_pressed("repeat_text"):
		read_text(subtitles.text + "")

	if event.is_action_released('main_menu'):
		$Options.visible = !$Options.visible
		GameState.paused = $Options.visible


func continue_story():
	GameState.story.ContinueMaximally()
	var text = GameState.story.GetCurrentText()
	var tags = GameState.story.GetCurrentTags()
	print(tags)

	for tag in tags:
		GameBus.handle_tag.emit(tag.split(':'))

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
	subtitles.focus_mode = Control.FOCUS_ALL
	subtitles.grab_focus()


func _ended():
	print("The End")


func _select_choice(index):
	GameState.story.ChooseChoiceIndex(index)
	continue_story()
