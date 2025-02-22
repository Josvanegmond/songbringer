extends Area3D
class_name NoteArea

# specify choice of scavenge location. use format loc_#; eg: hallway_1
@export var choice_name: String = ''
@export var selected_note: String

var note_cooldown = false

var sound_paths = {
	"notetone": "res://game_sounds/ui_sounds/notetone_loop.wav",
	"notetone_pickup": "res://game_sounds/ui_sounds/notetone_pickup.wav",
	"notetone_putdown": "res://game_sounds/ui_sounds/notetone_putdown.wav"
	}
#table to store data of written loot and notes the player finds. if you want this instance of scavenge_area to be found here, add to @export floor
var notes = {
	# format: "shard name": [type <"note", "rock", "crystal", etc>, untunedsound, pickupsound, putdownsound, description, soundcaption]
	# format of sound configs: [sound path, pitch, db, timeout, loop/nill]
	"notetone1": ["note", [sound_paths["notetone"], 1, 0, 10, "loop"], sound_paths["notetone_pickup"], sound_paths["notetone_putdown"], "This is a note left by the pilot. It has a slightly grating ringtone.", "A cheery jingle plays through a small speaker"]
}

func _ready() -> void:
	GameBus.player_scavenges.connect(_pick_scavenge_choice)

func _process(delta) -> void:
	pass
	

func _on_body_exited(body:Node3D) -> void:
	if body.name == 'Player':
		GameBus.player_cant_scavenge.emit()


func _on_body_entered(body:Node3D) -> void:
	if body.name == 'Player' && not note_cooldown:
		# play shard sound
		play_found_note(selected_note)
		GameBus.player_can_scavenge.emit(selected_note, notes[selected_note])
		# start timer cooldown until new shard can be found
		note_cooldown = true
		await get_tree().create_timer(notes[selected_note][1][3]).timeout
		if note_cooldown == true:
			stopnote()
		note_cooldown = false
		


func _pick_scavenge_choice(scavenge_spot: String):
	var current_choices: Array[InkChoice] = GameState.story.GetCurrentChoices()
	var choice_index = current_choices.find_custom(
		func (choice: InkChoice):
			var choice_tags = choice.GetTags()
			for tag in choice_tags:
				var tag_parts = tag.split(' ')
				return tag_parts.size() == 2 && tag_parts[0] == 'note_at' && tag_parts[1] == scavenge_spot
			return false
	)

	if choice_index >= 0:
		GameBus.select_choice.emit(choice_index)

func play_found_note(shard_name):
	var sound_configs = notes[selected_note][1]
	playnote(sound_configs[0], sound_configs[1], sound_configs[2])

func playnote(file, pitch, volume):
	file = load(file)
	$PickupNote1.set_stream(file)
	$PickupNote1.pitch_scale = pitch
	$PickupNote1.volume_db = volume
	$PickupNote1.play()

func stopnote():
	$PickupNote1.stop()
	note_cooldown = false
