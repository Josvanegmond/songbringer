extends Node3D


@export var choice_tag: String = ''
# turn on etherphone_active to have etherphone play when entering area. false by default, no etherphone effect
# to do: possibly 
@export var etherphone_active = false
@export var sound: AudioStream = null:
	get ():
		return sound
	set (audio_stream):
		sound = audio_stream
		update_sound()

@onready var audio_stream: AudioStreamPlayer3D = $AudioStreamPlayer3D

var song_snippet = "crackle"

var player_in_area = false

func _ready() -> void:
	update_sound()


func _input(event: InputEvent) -> void:
	if GameState.paused: return
	
	if player_in_area && event.is_action_pressed("interact"):
		var choices = GameState.story.GetCurrentChoices()
		for i in range(choices.size()):
			var choice: InkChoice = choices[i]
			var tags = choice.GetTags()
			for tag in tags:
				var tag_parts = tag.split(':')
				if tag_parts[0] == 'snippet' && tag_parts[1] == song_snippet:
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
		if etherphone_active == true:
			etherphone_active = false
			GameBus.etherphone.emit()
			print("etherphone emitted")
			await get_tree().create_timer(2).timeout
			etherphone_active = true


func _on_area_body_exited(body: Node3D) -> void:
	if body.name == 'Player':
		player_in_area = false

func _on_audio_bits_player_gramophone_song(snippet: String) -> void:
	song_snippet = snippet
