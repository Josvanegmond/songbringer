extends Area3D
class_name EntranceArea


@export var choice_name: String = ''

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
