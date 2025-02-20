extends Area3D
class_name ScavengeArea

# specify choice of scavenge location. use format loc_#; eg: hallway_1
@export var choice_name: String = ''
# specify any written loot that is already on floor at start of game. store any additional loot that is generated.
# note: discarded loot is removed from floor and lost forever
# format: "shard name": [type <"note", "rock", "crystal", etc>, untunedsound, pickupsound, putdownsound, description, soundcaption], 
@export var floor = {}
# specify what types of loot that can be found here. full inventory is <temp: "rock", "crystal", "scrap", "glass",>
@export var loot_pool = []
# specify largest amount of loot the floor can hold before no new sounds are generated, to prevent player from generating infinite loot. 
@export var floor_total = 10
# specify amount of loot that can be scavenged. For example, if location is just to pick up one note, setting loot_total to 1 will ensure no further loot is generated here.
# default null, unlimited loot. this is generally favorable so player won't get softlocked if they need a certain shard type
@export var loot_total = null

var selected_shard = null

var rng = RandomNumberGenerator.new()
var roundrobin = 1

var sound_paths = {
	"notetone": "res://game_sounds/ui_sounds/notetone_loop.wav",
	"notetone_pickup": "res://game_sounds/ui_sounds/notetone_pickup.wav",
	"notetone_putdown": "res://game_sounds/ui_sounds/notetone_putdown.wav"
	
	
	}
#table to store data of written loot and notes the player finds. if you want this instance of scavenge_area to be found here, add to @export floor
var written_loot = {
	"notetone1": ["note", [sound_paths["notetone"], 1, 0], sound_paths["notetone_pickup"], sound_paths["notetone_putdown"], "This is a note left by the pilot. It has a slightly grating ringtone.", "A cheery jingle plays through a small speaker"]
}

func _ready() -> void:
	GameBus.player_scavenges.connect(_pick_scavenge_choice)
	for w in floor.keys():
		if floor[w] == "written":
			floor[w] = written_loot[w]


func _on_body_exited(body:Node3D) -> void:
	if body.name == 'Player':
		GameBus.player_cant_scavenge.emit()


func _on_body_entered(body:Node3D) -> void:
	if body.name == 'Player':
		selected_shard = choose_shard()
		# play shard sound
		play_shard(selected_shard)
		GameBus.player_can_scavenge.emit(selected_shard, floor[selected_shard])
		# start timer cooldown until new shard can be found

func choose_shard():
	# priority given to notes
	for s in floor.keys():
		if floor[s][0] == "note":
			return(s)
	var new_shard_chance = rng.randi_range(0, 1)
	if new_shard_chance == 1:
		return new_shard()
	else:
		return floor.keys().pick_random()

func new_shard():
	pass
	# to do: create new shard based on stat pool
	# get shard description, caption
	# generate sounds
	# add all to floor
	# return shard name
	# var text = GameState.story.GetCurrentText()

func _pick_scavenge_choice(scavenge_spot: String):
	var current_choices: Array[InkChoice] = GameState.story.GetCurrentChoices()
	var choice_index = current_choices.find_custom(
		func (choice: InkChoice):
			var choice_tags = choice.GetTags()
			for tag in choice_tags:
				var tag_parts = tag.split(' ')
				return tag_parts.size() == 2 && tag_parts[0] == 'scavenge_at' && tag_parts[1] == scavenge_spot
			return false
	)

	if choice_index >= 0:
		GameBus.select_choice.emit(choice_index)

func play_shard(shard_name):
	for s in floor[shard_name][1]:
		var pitch = s[1]
		if pitch == null:
			pitch = rng.randf_range(.83,1.2)
		playnote(s[0], pitch, s[1])
func playnote(file, pitch, volume):
	file = load(file)
	# select roundrobin:
	match roundrobin: 
		1:
			roundrobin += 1
			#print("egg")
			$PickupNote1.set_stream(file)
			$PickupNote1.pitch_scale = pitch
			$PickupNote1.volume_db = volume
			$PickupNote1.play()
		2:
			roundrobin += 1
			$PickupNote2.set_stream(file)
			$PickupNote2.pitch_scale = pitch
			$PickupNote2.volume_db = volume
			$PickupNote2.play()
		3:
			roundrobin += 1
			$PickupNote3.set_stream(file)
			$PickupNote3.pitch_scale = pitch
			$PickupNote3.volume_db = volume
			$PickupNote3.play()
		4:
			roundrobin += 1
			$PickupNote4.set_stream(file)
			$PickupNote4.pitch_scale = pitch
			$PickupNote4.volume_db = volume
			$PickupNote4.play()
		5:
			roundrobin += 1
			$PickupNote5.set_stream(file)
			$PickupNote5.pitch_scale = pitch
			$PickupNote5.volume_db = volume
			$PickupNote5.play()
		6:
			roundrobin = 1
			$PickupNote6.set_stream(file)
			$PickupNote6.pitch_scale = pitch
			$PickupNote6.volume_db = volume
			$PickupNote6.play()
