extends Node


@export var story: InkStory:
	get():
		return GameState.story
	set(_story):
		GameState.story = _story


var subtitles: Label = null


func _ready():
	GameBus.select_choice.connect(_select_choice)
	continue_story()


func _input(event) -> void:
	if event.is_action_pressed("repeat_text"):
		read_text(subtitles.text + "")

	if event.is_action_pressed('main_menu'):
		$MainMenu.toggle()


func continue_story():
	GameState.story.ContinueMaximally()
	var text = GameState.story.GetCurrentText()
	var tags = GameState.story.GetCurrentTags()

	for tag in tags:
		GameBus.handle_tag.emit(tag.split(':'))

	read_text(text)


func read_text(text):
	var children = $VBox.get_children()
	for child in children:
		$VBox.remove_child(child)
	
	subtitles = Label.new()
	subtitles.add_theme_font_size_override('font_size', 30)

	# Works only for godot with acesskit 
	if 'accessibility_name' in subtitles:
		subtitles.accessibility_name = 'narration_text'

	subtitles.text = text
	subtitles.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$VBox.add_child(subtitles)
	subtitles.focus_mode = Control.FOCUS_ALL
	subtitles.grab_focus()

	TtsHelper.speak(subtitles.text)


func _ended():
	print("The End")


func _select_choice(index):
	GameState.story.ChooseChoiceIndex(index)
	continue_story()
