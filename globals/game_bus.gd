extends Node


signal player_can_enter_to(position: Vector3, choice_name: String, door_type: AudioStream)
signal player_cant_enter()
signal player_enters(entrance_name: String)
signal etherphone()


signal select_choice(choice_index: int)
signal handle_tag(tag_parts: Array[String])

# pass audiostreamrandomizer to set, send anything else to reset to default
signal change_footstep(step_type)
