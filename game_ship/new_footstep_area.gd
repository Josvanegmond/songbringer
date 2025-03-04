extends Area3D
class_name NewFootstepArea

@export var step_type: AudioStream = null



func _ready() -> void:
	pass


func _on_body_exited(body:Node3D) -> void:
	if body.name == 'Player':
		GameBus.change_footstep.emit("reset")


func _on_body_entered(body:Node3D) -> void:
	if body.name == 'Player':
		GameBus.change_footstep.emit(step_type)
		
