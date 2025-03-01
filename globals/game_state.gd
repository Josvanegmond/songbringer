extends Node

var story: InkStory = null

var paused = false
var key_rebinding = false


var ambient_volume = 0
var music_volume = 0
var master_volume = 0
var sound_volume = 0
var tts_volume = 50
var tts_rate = 1.0


var tts_over_screenreader = true
var selected_voice = null
var available_voices = 0
var inventory = {}

signal on_toggle_tts_over_screenreader(enabled: bool)


func has_shard(shard_name):
	return shard_name in inventory

func sync_inventory_with_ink(ink_story):
	ink_story.variables_state["piano_song"] = has_shard("piano_shard")
	ink_story.variables_state["flute_song"] = has_shard("flute_shard")
	ink_story.variables_state["violin_song"] = has_shard("violin_shard")
	ink_story.variables_state["drum_song"] = has_shard("drum_shard")
	ink_story.variables_state["voice_song"] = has_shard("voice_shard")

func toggle_tts_over_screenreader():
	if tts_over_screenreader:
		inform_tts(false)
		tts_over_screenreader = !tts_over_screenreader
	else:
		tts_over_screenreader = !tts_over_screenreader
		inform_tts(true)
	
	on_toggle_tts_over_screenreader.emit(tts_over_screenreader)


func inform_tts(enabled):
	var tts_state_speech = 'Native platform text to speech is '
	if enabled: tts_state_speech += 'enabled'
	else: tts_state_speech += 'disabled'
	TtsHelper.speak(tts_state_speech)