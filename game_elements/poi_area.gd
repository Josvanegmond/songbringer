extends Node3D


@export var choice_tag: String = ''
@export var sound: AudioStream = null:
	get ():
		return sound
	set (audio_stream):
		sound = audio_stream
		update_sound()

@onready var audio_stream: AudioStreamPlayer3D = $AudioStreamPlayer3D

var player_in_area = false


func _ready() -> void:
	update_sound()


func _input(event: InputEvent) -> void:
	if player_in_area && event.is_action_pressed("interact"):
		var choices = GameState.story.GetCurrentChoices()
		for i in range(choices.size()):
			var choice: InkChoice = choices[i]
			var tags = choice.GetTags()
			for tag in tags:
				var tag_parts = tag.split(':')
				if tag_parts[0] == 'area' && tag_parts[1] == choice_tag:
					GameBus.select_choice.emit(i)
					return



func update_sound():
	if !audio_stream: return
	
	audio_stream.stream = sound
	if sound: audio_stream.play()
	else: audio_stream.stop()



func _on_area_body_entered(body: Node3D) -> void:
	if body.name == 'Player':
		player_in_area = true


func _on_area_body_exited(body: Node3D) -> void:
	if body.name == 'Player':
		player_in_area = false
