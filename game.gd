extends Node


@export var story: InkStory:
	get():
		return GameState.story
	set(_story):
		GameState.story = _story


@onready var main_menu_scene = $MainMenu
@onready var viewport = $HBoxContainer/SubViewportContainer
@onready var text_box = $HBoxContainer/SubtitleBox

@onready var intro_scene = $Intro
@onready var intro_text_box = $Intro/VBoxContainer/SubtitleBox
@onready var intro_button = $Intro/VBoxContainer/Button


var default_label_tscn = preload('res://game_elements/default_label.tscn')


var subtitles: Label = null


func _ready():
	GameBus.select_choice.connect(_select_choice)
	continue_story()


func _input(event) -> void:
	if event.is_action_pressed("repeat_text"):
		read_text(subtitles.text + "")
		# Pretty ugly way to do this but whatever works
		# re-prompt handle_intro to maintain focus on continue button
		if intro_scene.visible:
			handle_intro()
	if event.is_action_pressed('main_menu'):
		# main seems to be disabled on intro, so adding this temporarily to avoid de-focusing continue button
		if not intro_scene.visible:
			main_menu_scene.toggle()
	# Pretty ugly way to do this but whatever works
	# failsafe: if player somehow deselects continue button in intro, pressing continue will re-focuse continue button
	if event.is_action_pressed("interact"):
		if intro_scene.visible:
			handle_intro()


func continue_story():
	GameState.story.ContinueMaximally()
	var text = GameState.story.GetCurrentText()
	var tags = GameState.story.GetCurrentTags()

	print(text)
	for choice in GameState.story.GetCurrentChoices():
		print(choice.GetText())

	for tag in tags:
		# for each tag (separated by space), split it by colon into instruction and arguments
		var split_tag = tag.split(':')
		# Split the arguments into an array by comma separation
		var tag_args = split_tag[1].split(',') if split_tag.size() > 1 else [] 
		handle_tag(split_tag[0], tag_args) # handle tags here
		GameBus.handle_tag.emit(split_tag[0], tag_args) # everyone else listening to handle_tag also can handle tags

	read_text(text)

	# Pretty ugly way to do this but whatever works
	if intro_scene.visible:
		handle_intro()


# Will show the choice button on the intro scene, expected to be only one
func handle_intro():
	var choices = GameState.story.GetCurrentChoices()
	if choices.size() > 0:
		var choice: InkChoice = choices[0]
		intro_button.text = choice.GetText()
		intro_button.grab_focus()
	
# Handles scene tag instructions from ink
func handle_tag(tag, args):
	if tag == 'show_all':
		story.ContinueMaximally()
		return

	if tag == 'scene':
		if args[0] == 'reset':
			intro_scene.visible = false

		if args[0] == 'intro':
			intro_scene.visible = true
			intro_button.pressed.connect(func (): _select_choice(0))
	
	if tag == "add_shard" and args.size() > 0:
		add_shard_to_inventory(args[0])

func add_shard_to_inventory(shard_name: String):
	if not GameState.inventory.has("shards"):
		GameState.inventory["shards"] = []
	
	if shard_name not in GameState.inventory["shards"]:
		GameState.inventory["shards"].append(shard_name)
		print("Shard added: ", shard_name)



# Shows text in game or in the intro
func read_text(text):
	var active_text_box = text_box

	if intro_scene.visible:
		active_text_box = intro_text_box

	var children = active_text_box.get_children()
	for child in children:
		active_text_box.remove_child(child)
	
	subtitles = default_label_tscn.instantiate()

	# Works only for godot with acesskit 
	if 'accessibility_name' in subtitles:
		subtitles.accessibility_name = 'narration_text'

	subtitles.text = text
	subtitles.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	active_text_box.add_child(subtitles)

	subtitles.focus_mode = Control.FOCUS_ALL
	subtitles.grab_focus()

	TtsHelper.speak(subtitles.text)


func _ended():
	print("The End")


func _select_choice(index):
	GameState.story.ChooseChoiceIndex(index)
	continue_story()
