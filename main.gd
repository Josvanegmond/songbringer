extends Control


signal scene_finished(node)


@export var scenes: Array[PackedScene] = []
var load_scene_index = 0
var current_scene_node: Node = null


func _ready() -> void:
	scene_finished.connect(handle_scene_finished)

	GameState.available_voices = DisplayServer.tts_get_voices_for_language('en')
	if GameState.available_voices.size() > 0:
		GameState.selected_voice = GameState.available_voices[0]

	load_scene()



func load_scene():
	if current_scene_node:
		remove_child(current_scene_node)
		current_scene_node.queue_free()

	var packed_scene: PackedScene = scenes[load_scene_index]
	current_scene_node = packed_scene.instantiate()
	add_child(current_scene_node)


func _input(event: InputEvent) -> void:
	if GameState.key_rebinding: return
	
	if event.is_action_released("toggle_text_to_speech"):
		GameState.toggle_tts_over_screenreader()

	if event.is_action_released("skip_speech"):
		TtsHelper.speak('')


func handle_scene_finished(_node: Node):
	load_scene_index += 1
	load_scene()


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		TtsHelper.stop_speak()
