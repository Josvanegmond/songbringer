extends Node


signal player_can_enter_to(position: Vector3, choice_name: String)
signal player_cant_enter()
signal player_enters(entrance_name: String)


signal player_can_scavenge(shard_name: String, shard_info: Array)
signal player_cant_scavenge()
# add shard to inventory
signal player_scavenges(shard_name: String, shard_info: Array)


signal select_choice(choice_index: int)
signal handle_tag(tag_parts: Array[String])
