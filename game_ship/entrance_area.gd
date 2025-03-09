extends Area3D
class_name EntranceArea


@export var choice_name: String = ''
@export var handle_active: bool = true
@export var handle_type: AudioStream = null
@export var door_sound: AudioStream


func _ready() -> void:
	GameBus.player_enters.connect(_pick_entrance_choice)
	update_sound()


@export var connected_area: EntranceArea = null:
	get():
		return connected_area
	set(area):
		connected_area = area


func _on_body_exited(body:Node3D) -> void:
	if body.name == 'Player':
		GameBus.player_cant_enter.emit()


func _on_body_entered(body:Node3D) -> void:
	if body.name == 'Player':
		GameBus.player_can_enter_to.emit(connected_area.global_position, choice_name, door_sound)
		if handle_active == true:
			handle_active = false
			play_handle()
			await get_tree().create_timer(2).timeout
			handle_active = true
		

func _pick_entrance_choice(entrance_name: String):
	var current_choices: Array[InkChoice] = GameState.story.GetCurrentChoices()
	var choice_index = current_choices.find_custom(
		func (choice: InkChoice):
			var choice_tags = choice.GetTags()
			for tag in choice_tags:
				var tag_parts = tag.split(':')
				return tag_parts.size() == 2 && tag_parts[0] == 'entrance_to' && tag_parts[1] == entrance_name
			return false
	)

	if choice_index >= 0:
		GameBus.select_choice.emit(choice_index)

#for handle sound on entry to collision area
func update_sound():
	if handle_active == true:
		$HandlePlayer.set_stream(handle_type)

func play_handle():
	$HandlePlayer.play()
