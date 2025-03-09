-> game_begins

VAR piano_song = false
VAR flute_song = false
VAR violin_song = false
VAR drum_song = false
VAR voice_song = false

VAR piano_returned = false
VAR flute_returned = false
VAR violin_returned = false
VAR drum_returned = false
VAR voice_returned = false
VAR shrine_found = false

=== game_begins ===
#music_play:main
#scene:intro
#player:freeze
A song beckons to you across space. [To continue, press Enter, Space, or Controller Buttons; to repeat, press R or Left Controller Button]

+ [LISTEN]
	#player_sound:etherphone_pickup.tres
	- With your etherphone, you trace its call to an arboreal planet, dense with greenery and foliage. In the midst of this planet’s solitude stands the wreckage of an old ship. [To continue, press Enter, Space, or Controller Buttons; to repeat, press R or Left Controller Button]

+ [CONTINUE]
	- This is the EURYDICE ——— an abandoned spacecraft of unknown origin. Decorated with a constellation of wounds, she has been laid to rest in a lonely grove. A large tree blooms from within her heart. [To continue, press Enter, Space, or Controller Buttons; to repeat, press R or Left Controller Button]

+ [CONTINUE]
	- All around you, life hums. Is it the tree, the planet, or the ship itself that called you here? You know not, but not much harkens to a scavenger as much as the song of discovery, arriving before you! [Use left and right arrows or A D to move and space bar to interact. Press enter or space to enter the Eurydice]

+ [ENTER THE SHIP]
    #player:unfreeze
	#scene:reset
	- -> engine_room


=== engine_room ===
#music_play:silence
#light_level:0.4
#amb_play:engine_atm_loop
#amb_play_eurydice:on
{You crawl into the ship through a gap in its underside, surfacing in the ship's engine room. The gnarled roots of a tree have sunken deep through this floor.|The ghost of a voice lingers.}

- (choices)
+ [pipes #area:pipes]
	{Noise, everywhere: the faint sound of pipes sputtering, the hiss of escaping steam, and the melody that brought you here.|Life and noise, stubbornly persisting in the room.}

+ [tree #area:tree]
#amb_play:engine_ending_atm_loop
{
    - piano_song:
	    #player_sound:piano_shard.ogg
        #remove_shard:piano_shard
        ~ piano_song = false
        ~ piano_returned = true
        You brought the Shard of the Medic. The chords of the keyboard tinkle, ethereal, softening the room around you.
    - flute_song:
	    #player_sound:flute_shard.ogg
        #remove_shard:flute_shard
        ~ flute_song = false
        ~ flute_returned = true
        You brought the Shard of the Mechanic. The flute whistles a clear, bright tone. The wind rises to meet it in a harmony of breath and song. Soon, it calls to you. Soon the promise of discovery anew.
    - violin_song:
        #player_sound:violin_shard.ogg
	    #remove_shard:violin_shard
        ~ violin_song = false
        ~ violin_returned = true
        You brought the Shard of the Captain. You hope one day it finds what it was looking for.
    - drum_song:
    	#player_sound:percussion_shard.ogg
        #remove_shard:drum_shard
        ~ drum_song = false
        ~ drum_returned = true
        You brought the Shard of the Pilot. The drum strikes a crisp, lively melody. The shrine thrums to life with each steady beat. Here I am, here I am, it seems to say, joining you in song.
    - voice_song:
        #player_sound:nil
	    #remove_shard:voice_shard
        ~ voice_song = false
        ~ voice_returned = true
        You brought the Shard of the Navigator. His voice stirs from the speaker of your etherphone.
    - piano_returned and flute_returned and violin_returned and drum_returned and voice_returned:
        {
            - not credits:
                #music_play:symphonictheme
                #player:freeze
                {You gather the five shards before the heart of the tree. The Mechanic's flute, the Pilot's drum, the Medic's piano, the Captain's violin, and the Navigator's voice, captured with your etherphone. The tree hums in anticipation. | This was the Mechanic's last wish\: the final symphony of the crew. | You listen as the Eurydice performs in song-wed twine, joined together once more. The hum of the tree rises to meet the crew's melodies in full. You wonder if this is what the strange signal had been searching for, too, if this is what drew the Eurydice here, across this lonely stretch of the universe — another voice to answer its call.|-> credits}
            - else:
                {&You stand before it all, wreathed in song.|-> credits}
        }
    - else:
        {&The tree has rooted itself deep inside the ship's engine, humming, waiting. Is this what called out to you? Wasn't Eurydice originally a tree nymph? Maybe she found a home on this strange planet.|-> tally_shards}
}

//IF ALL COLLECTED:
//{flute_song && drum_song && piano_song && violin_song && voice: You gather the five shards before the heart of the tree: the Mechanic's flute, the Pilot's drum, the Medic's piano, the Captain's violin, and the Navigator's voice, captured with your etherphone. The tree hums in anticipation.|: This was the Mechanic's last wish: the final symphony of the crew.|You listen as the Eurydice performs in song-wed twine, joined together once more. The hum of the tree rises to meet the crew's melodies in full. You wonder if this is what the strange signal had been searching for, too, if this is what drew the Eurydice here, across this lonely stretch of the universe — another voice to answer its call.|You stand before it all, wreathed in song. -> END}

+ [recorder #area:recorder]
	{A small, rectangular device sits at the base of the tree. It's a cassette recorder! A single tape is loaded into it.|<- tape_1}

+ [engine_to_hallway #entrance_to:engine_to_hallway]
	-> hallway_lvl1


- -> engine_room.choices


= credits
#player:unfreeze
Thank you so much for playing, enjoy the final symphony of the crew of the Eurydice. This game was a collaboration of love from Calosja, Ang, Tangent Sacket Pyle, Thomas Mezzie, Ogrehara, and Joozey.
-> engine_room.choices


= tally_shards
Bring back the shards of {not piano_returned: the medic, }{not flute_returned: the mechanic, }{not violin_returned: the captain, }{not drum_returned: the pilot, }{not voice_returned: the navigator, } to this tree.
-> engine_room.choices


= tape_1
{A voice crackles to life. "Hey. I don't know who's going to be on the other end of this, but if you've gotten here, I just ask that you listen this once."|I'm the last survivor of the Eurydice. The last of my crew. And — hah — I'll be joining them soon, so I guess you can consider this my will. Congratulations on stumbling across this. A silly, selfish request from someone who’s running out of time.|I don't have the luxury to explain everything that happened here, but maybe you're clever enough to figure it out. Or maybe you don't even care, and I'm just nattering to a strip of tape like I always do! They always teased me for that.|But ... if you really are here with me ... let me say this. We poured all of ourselves into this hunk of steel and wires. I refuse to let the Eurydice end up being a cold, empty tomb swallowed up by —  by silence. She was never meant to be this quiet.|There were five of us. Five songs. The Captain... the Mechanic... the Medic... the Pilot... and the Navigator.|Each one of us left a piece of ourselves behind, like... like a little memory. I want you to find these Shards and bring them back here to this tree. You'll find mine a few steps away from here. Just follow the music. The tree, the plants, this planet — it'll make sense the deeper you venture in.|I just want to be with my crew again. I can’t bring them back, but I want to know some part of the universe recognized our small existence. That someone was listening.|I guess that's all I can really ask you to do in the end. The you who arrived here with me. Please listen." The tape ends.|{~The tape has ended, but the ghost of a voice lingers.|The voice asked you to find the music shards of the five crew members, and bring it to the tree in the engine.}}
-> engine_room.choices


=== hallway_lvl1 ===
#light_level:0.6
#amb_play:none
#amb_play_eurydice:on
#music_play:none
#ambience_play:hallway_ambience.ogg
{You uncover a hallway,|The hallway is} narrow and dark.

- (choices)
+ [hallway_to_engine #entrance_to:hallway_to_engine]
	-> engine_room

+ [hallway_to_medbay #entrance_to:hallway_to_medbay]
	-> medbay

+ [hallway_to_obs #entrance_to:hallway_to_obs]
	-> obsdeck

+ [hallway_to_command #entrance_to:hallway_to_command]
	-> command

+ [flute #area:flute]
{
    - not found_flute:
        #player:freeze
        {From beneath a tangle of foliage, you hear the muffled sound of pipes. Your etherphone tells you another shard is here.|You try tearing at the plants, and begin dislodging a wooden object. You silently apologize to the plants as its song grows louder.|->found_flute}
    - else:
        {As the flute echoes freely, the tangle of plants shake and dance, almost as if in response to the whistling.|You salute the plants for having excellent taste in music. You wonder how long it's been since they were able to dance like that.}
}

- -> hallway_lvl1.choices

=found_flute
#player:unfreeze
#player_sound:flute_shard.ogg
#add_shard:flute
~ flute_song = true
It's a flute! Strange green pores are speckled across its surface. Its melody is warm and rich — but still, how strange to hear an instrument without a player.  You found the Flute. 
-> hallway_lvl1.choices



=== medbay ===
#light_level:0.5
#amb_play:med_atm_loop
#amb_play_eurydice:off
#music_play:none
 A standard hospital room, save for the archaic record player collecting dust in a corner of the space. The space still feels sterile, despite years of obvious neglect.

- (choices)

+ [desk #area:desk]
    #player:freeze
    {You spy torn scraps of paper on the desk. Tucked away below is a wide closed drawer.|The papers look like logs from a psych evaluation. You can barely make out the script.| LOG, PSYCH EVALUATION: CAPTAIN, 029.4020.22XX|CAPTAIN:  I'm not going crazy, am I?|MEDIC:  No, you're not crazy. I've experienced loss as well. As you know.|CAPTAIN:  That signal is the last thing we have of him. I'm not abandoning him knowing that he's just waiting for us to listen.|To find him.|That’s all you can read.|You open the drawer. Inside is a piano keyboard.|The keyboard is dusty and blanketed in the same green spores as the other instruments.|Despite this, it still carries an elegant, dignified presence.|->found_piano|The sounds of the keyboard seem to resonate against the scratching gramophone. How sad, how lovely, how alive.}

+ [gramophone #area:gramophone]
{
    - !shrine_found:
        An antique record player. The spinning disk is covered in spores.
    - shrine_found:
        You approach the record player, gently placing the worn pilot’s record you found earlier onto the turntable. The needle crackles to life, and for a moment, the room is filled with the faint sound of static, as if the past is slowly waking.
}

+ [medbay_to_hallway #entrance_to:medbay_to_hallway]
	-> hallway_lvl1

+ { not found_piano } [piano #area:piano]
    -> found_piano

- -> medbay.choices

=found_piano
#player:unfreeze
#player_sound:piano_shard.ogg
#add_shard:piano
~ piano_song = true
Phantom chords are strung into a cresting ballad that breaks through the quiet of the medical bay. You found the Piano shard.
-> medbay.choices


=== obsdeck ===
#light_level:1.0
#amb_play:obs_atm_loop
#amb_play_eurydice:off
#music_play:sunshine
The tree stretches through most of the observation deck's roof and windows, bathing the area in a sea of broken glass and light. A small shrine rests in the middle of the room, possessing a quaint serenity amid the debris.

- (choices)

+ [shrine #area:shrine]
 ~ shrine_found = true
{At the center of the shrine is a portrait of a smiling middle-aged human wearing a standard pilot's outfit. There is a small gap in their front teeth. |They seem happy.|Near the shrine, you find a record. It’s too worn for you to read the title, but a small note is taped to the front.|"For my dear Pilot. Thank you for listening.”}


+ { not found_drum } [drum #area:drum]
#player:freeze
{A snare drum, adorned with the same green spores you found earlier.|Its head is battered with faded lines, marking years of use, but the metal wiring and shell remain in impeccable shape. | -> found_drum}

+ [obs_to_hallway #entrance_to:obs_to_hallway]
	-> hallway_lvl1

- -> obsdeck.choices

=found_drum
#player:unfreeze
#player_sound:percussion_shard.ogg
#add_shard:drum
~ drum_song = true
 It quietly taps out a steady rhythm, as if echoing a melody only it remembers.  You found the Drum. 
-> obsdeck.choices

=== command ===
#light_level:0.8
#amb_play:command_atm_loop
#music_play:echoes
The crash has left the command room in a state of disarray, with wires and debris skittering around the floor. Green spores float in scattered dance. Phantom sounds echo beneath the static hum of the room.

- (choices)

+ [computer #area:computer]
    {
        - not found_voice:
            #player:freeze
            {&Miraculously, this computer seems to be just barely in working order. On the screen, you find an archive of various files and conversation logs snippets.|You click the first one you see.|COMMAND LOG 190.30.22XX|CAPTAIN: This is the closest we've ever gotten. I'm not leaving him again.|MECHANIC: Captain, please. Just stay.|CAPTAIN: You don't have to come with me, I promise. You can take the ship and leave.|It's the least I can do for you, after everything. You should've left with the Medic. Before the Pilot —|LOG CORRUPTED.|You click the next one.|COMMAND LOG: 001.97.20XX|NAVIGATOR: Alright, I've finished training the Mechanic on the general layout of the ship. We can walk them through the engine room once we've sorted out the mess with the water filtration.|CAPTAIN: Copy, sir.|NAVIGATOR: These kinds of tasks should really be your job, you know.|CAPTAIN: What's a Captain without a capable Navigator as their right hand?|NAVIGATOR: Hmph. I think you're just lazy sometimes. CAPTAIN: See, I like to call it the art of delegation!|CAPTAIN: Anywho, I think we're all due for a little break soon. Maybe we can stop on that one planet? The one with the funky cantina karaoke? That could be fun. We can celebrate the addition of our bright new crew member!|NAVIGATOR: Fine. I agree we've been on the road for longer than usual.|CAPTAIN: Yes! Can't wait to see the kid swoon at the sound of your sweet, dulcet tones.|NAVIGATOR: Before that, though, I'm going to make a quick detour.|CAPTAIN: Oh, what's captured the curiosity of our inscrutable Navigator?|NAVIGATOR: I'll tell you about it later. It's getting late.|COMMAND LOG ROOT| The last file seems to be an audio recording.|You hear silence, and then a voice emerges from the depths of memory.|Melodious, evocative, with the shadow of soft laughter. Before it disappears again, you capture it in your etherphone.|->found_voice}
        - else:
            {&How do you know when something has arrived in your life?|When it calls to you, unbidden}
    }
    
+ [drawer #area:drawer]
{
    - not found_violin:
        #player:freeze
        {You hear the sound of strings from a desk drawer.|Inside sits a violin with no bow. Spores are speckled on its long neck. It seems lonely by itself here.|->found_violin}
    - else:
        The desk lies quietly.
}

+ [command_to_hallway #entrance_to:command_to_hallway]
	-> hallway_lvl1

- -> command.choices

=found_voice
//#player_sound:voice_shard.ogg
#player:unfreeze
#add_shard:voice
~ voice_song = true
 You found the Voice shard. 
-> command.choices

=found_violin
#player:unfreeze
#player_sound:violin_shard.ogg
#add_shard:violin
~ violin_song = true
{The song swells and dances across the strings. You wonder if it's chasing something.  You found the Violin shard. |The desk sags elaborately under its own weight.} 
-> command.choices

-> END