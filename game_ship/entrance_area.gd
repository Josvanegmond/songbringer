extends Area3D
class_name EntranceArea


@export var choice_name: String = ''


func _ready() -> void:
	GameBus.player_enters.connect(_pick_entrance_choice)


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
		GameBus.player_can_enter_to.emit(connected_area.global_position, choice_name)



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
