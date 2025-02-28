-> game_begins

=== game_begins ===
#music_play:main
#scene:intro
A song beckons to you across space.

+ [LISTEN]
    #player_sound:etherphone_open.ogg
    - With your etherphone, you trace its call to an arboreal planet, dense with greenery and foliage. In the midst of this planet’s solitude stands the wreckage of an old ship.

+ [CONTINUE]
    - This is the EURYDICE — an abandoned spacecraft of unknown origin. Decorated with a constellation of wounds, she has been laid to rest in a lonely grove. A large tree blooms from within her heart. 

+ [CONTINUE]
    - All around you, life hums. Is it the tree, the planet, or the ship itself that called you here? You know not, but not much harkens to a scavenger as much as the song of discovery, arriving before you!

+ [ENTER THE SHIP]
    #scene:reset
    - -> engine_room


=== engine_room ===
#music_play:silence
#light_level:0.4
{engine_room == 1: You crawl into the ship through a gap in its underside, surfacing in what appears to be the ship's engine room. The gnarled roots of a tree have sunken deep through this floor.}

{flute_song && drum_song && piano_song && violin_song && voice: You gather the five shards before the heart of the tree: the Mechanic's flute, the Pilot's drum, the Medic's piano, the Captain's violin, and the Navigator's voice, captured with your etherphone. The tree hums in anticipation.}

{flute_song && drum_song && piano_song && violin_song && voice: This was the Mechanic's last wish: the final symphony of the crew.}

// + {flute_song && drum_song && piano_song && violin_song && voice} [LISTEN]
//     -> final_song
    
// + {tape_1} [LISTEN TO TAPE]
//     ->tape_1
    
// + {tape_1} [GO TO HALLWAY]
//     -> hallway_lvl1
- (choices)
+ [pipes #area:pipes]
    {You hear the faint sound of pipes sputtering, the occasional hiss of escaping steam, a low groan as the ship shifts. You hear the faint melody on your etherphone that brought you here.|Gas still {~flows|rushes|travels} through rusted and worn pipes that entangle the engine room. {~You wonder w|W}hat other {~ship parts|parts of this {~vessel|ship}} still {~function|breathe|{~hold on|cling} to life...}}

+ [tree #area:tree]
    {
        - piano_song:
            You brought the piano shard
        - flute_song:
            You brought the flute shard
        - violin_song:
            You brought the violin shard
        - drum_song:
            You brought the drum shard
        - else:
            {The tree has rooted itself deep inside the ship's engine. Yet somehow, it is still humming, still glowing. Its purpose no longer to propel. What its purpose is, eludes you still.|The engine casts a strange warm light on the dense tangle of tree roots. It seems like the tree is connected to the engine.|The tree is {~waiting|looking|longing} for something, {~perhaps you can {~bring|find} it|what could it be|what does it want}?}
    }

+ [recorder #area:recorder]
    {A small, rectangular device sits at the base of the tree. It's a cassette recorder! A single tape is loaded into it.|<- tape_1}

+ [piano #area:piano]
    {It's the source of the melody you keep hearing!|<- found_piano}

+ [engine_to_hallway #entrance_to:hallway]
- -> engine_room.choices


= tape_1
{A voice crackles to life. "Hey. I don't know who's going to be on the other end of this, but if you've gotten here, I just ask that you listen this once."|I'm the last survivor of the Eurydice. The last of my crew. And — hah — I'll be joining them soon, so I guess you can consider this my will. Congratulations on stumbling across this. A silly, selfish request from someone who’s running out of time.|I don't have the luxury to explain everything that happened here, but maybe you're clever enough to figure it out. Or maybe you don't even care, and I'm just nattering to a strip of tape like I always do! They always teased me for that.|But ... if you really are here with me ... let me say this. We poured all of ourselves into this hunk of steel and wires. I refuse to let the Eurydice end up being a cold, empty tomb swallowed up by —  by silence. She was never meant to be this quiet.|There were five of us. Five songs. The Captain... the Mechanic... the Medic... the Pilot... and the Navigator.|Each one of us left a piece of ourselves behind, like... like a little memory. I want you to find these Shards and bring them back here to this tree. You'll find mine a few steps away from here. Just follow the music. The tree, the plants, this planet — it'll make sense the deeper you venture in.|I just want to be with my crew again. I can’t bring them back, but I want to know some part of the universe recognized our small existence. That someone was listening.|I guess that's all I can really ask you to do in the end. The you who arrived here with me. Please listen." The tape ends.|{~The tape has ended, but the ghost of a voice lingers.|The voice asked you to find the music shards of the five crew members, and bring it to the tree in the engine.}}
-> DONE

= found_piano
# player_sound:piano_shard.ogg
# add_shard:piano
-> DONE

=== hallway_lvl1 ===

The hallway is narrow and dark. At the end of it is a ladder leading into the ship's second level. Light peeks in from above.

{not flute_song: A thick tangle of plants and vines is preventing you from climbing up. These must be friends of this strange planet, not the ship.}

{flute_song: As the flute echoes freely throughout the hallway, you are surprised to find the tangle of plants shaking and dancing, almost as if in response to the whistling. They slowly uncoil away from the ladder. The path is now open!}

+ [EXAMINE]
    -> tangle

+ [SEARCH AREA]
    -> hallway_ground
    
+ {flute_song} [CLIMB UP]
    -> hallway_lvl2

=== tangle ===

{not flute_song: You try tearing at the plants, but they don't budge. You silently apologize to the plants.}

{flute_song: You salute the plants for having excellent taste in music. You wonder how long it's been since they were able to dance like that.}

+ ->hallway_lvl1

=== hallway_ground ===

{not flute_song: You're not able to see much, but your etherphone picks up a soft, whistling sound nearby. When you crouch down, you can make out the sound buried underneath a pile of leaves and rusted machine parts.}

{flute_song: Your etherphone detects nothing but the dripping of pipes and groan of metal.}

+ {not flute_song} [EXAMINE]
    -> flute
    
+ [RETURN]
    -> hallway_lvl1
    
=== flute ===

It's a flute! The melody is warm and rich — but still, how strange to hear an instrument without a player.

+ [EXAMINE]
    -> flute_desc
    
+ [LISTEN]
    -> flute_song
    
=== flute_desc ===

The flute is handcrafted from a pale, lightweight wood, polished smooth by years of careful hands. Though delicate in appearance, the instrument feels sturdy. Strange green pores are speckled across its surface.

Did this belong to the same owner of the recorder?

-> flute

    
=== flute_song ===

The flute whistles a clear, bright tone. The wind rises to meet it in a harmony of breath and song. Soon, it calls to you. Soon the promise of discovery anew.

<i> You now have the SHARD of the FLUTE. </i>

+ [RETURN]
    -> hallway_lvl1

=== hallway_lvl2 ===

The ladder creaks as you ascend to the top level of the ship.

You emerge in another hallway leading to several other rooms. You feel a rush of air through broken windows and open doors. 

+ [GO TO MEDICAL BAY]
    -> medbay
    
+ [GO TO OBSERVATION DECK]
    -> obsdeck
    
+ [GO TO COMMAND ROOM]
    -> command
    
=== medbay ===
 A standard hospital room, save for the archaic record player collecting dust in a corner of the space. The space still feels sterile, despite years of obvious neglect.

+ [SEARCH AREA]
    -> medbay_area

+ [LEAVE]
    -> hallway_lvl2
    
=== medbay_area ===

+ [DESK]
    -> medbay_desk

+ [RECORD PLAYER]
    -> record_player
    
=== medbay_desk ===

You spy a clipboard with a leaf full of papers on the top of the desk. Tucked away below is a closed drawer.

+ [EXAMINE PAPERS]
    -> papers
    
+ [OPEN DRAWER]
    -> drawer

+ [SEARCH ELSEWHERE]
    -> medbay_area
    
+ [LEAVE]
    -> medbay

=== papers ===

The papers seem to be a series of conversation logs. You begin reading.

<i><b> LOG, PSYCH EVALUATION: CAPTAIN, 029.4020.22XX

<b>CAPTAIN</b>: <i> I'm not going crazy, am I?
<b>MEDIC</b>: <i> No, you're not. 
<b>CAPTAIN</b>: <i> I bet you tell all the pretty spaceboys that.
<b>MEDIC</b>: <i> I would never call you pretty, Captain.
<b>CAPTAIN</b>: <i> [laughs] Yeah, I know. Bad joke.
<b>MEDIC</b>: <i> It's ok to talk about things, you know. 
<b>CAPTAIN</b>: <i> I know. That's why I'm here. I just - I'm not crazy, yeah?
<b>MEDIC</b>: <i> No, you're not crazy. I've experienced loss as well. As you know.
<b>CAPTAIN</b>: <i> I know. I'm sorry. But this isn't loss. He's not dead. He's just not here. 
<b>CAPTAIN</b>: <i> I can hear him. I know he's out there.
<b>MEDIC</b>: <i> I want to believe that as well. 
<b>CAPTAIN</b>: <i> But you don't.
<b>MEDIC</b>: <i> I just don't think it's practical to continue chasing after a signal we heard once years ago. Maybe it's time that we focus our energies elsewhere. 
<b>CAPTAIN</b>: <i> That signal is the last thing we have of him. I'm not abandoning him knowing that he's just waiting for us to listen. To find him.

<i><b> END LOG.

+ [RETURN]
    -> medbay_desk
    
=== drawer ===

{not medic_record: The drawer is locked, but your etherphone detects a strong, resonant timbre from within.}

{medic_record: The key from the Pilot's shrine unlocks the drawer! Inside sits a piano keyboard.}

+ {medic_record} [EXAMINE]
    -> piano
    
+ {medic_record} [LISTEN]
    -> piano_song

+ [RETURN]
    -> medbay_desk

=== piano ===

The keyboard is dusty and blanketed in the same green spores as the other instruments. Despite this, it still carries an elegant, dignified presence. 

+ [RETURN]
    -> drawer
    
=== piano_song ===

Phantom chords are strung into a cresting ballad that breaks through the quiet of the medical bay. How sad, how lovely, how alive.

<i> You now have the SHARD of the PIANO.

+ [RETURN]
    -> drawer

=== record_player ===

An antique record player.

+ [PLAY RECORD]
    -> record_song

+ [SEARCH ELSEWHERE]
    -> medbay_area
    
+ [LEAVE]
    -> medbay
    
=== record_song ===

X

+ [RETURN]
    -> record_player
 
=== obsdeck ===
The tree from the engine room below stretches through most of the observation deck's roof and windows, bathing the area in a sea of broken glass and light. A small shrine rests in the middle of the room, possessing a quaint serenity amid the debris.

+ [EXAMINE SHRINE]
    -> shrine

+ [LEAVE]
    -> hallway_lvl2

=== shrine ===

At the center of the shrine is a portrait of a smiling middle-aged human wearing a standard pilot's outfit. There is a small gap in their front teeth. They seem happy.

Some mementos encircle the portrait. A record, and a snare drum, though untouched, that quietly taps out a steady rhythm, as if echoing a melody only it remembers.

+ [EXAMINE RECORD]
    -> medic_record
    
+ [EXAMINE DRUM]
    -> drum
    
+ [LEAVE]
    -> obsdeck
    
=== medic_record ===

The record is too worn for you to read the title, but a small note is taped to the front: "For my dear Pilot. Thank you for listening."

A key slips out of the cover.

<i> You now have the SMALL KEY.

+ [RETURN]
    -> shrine
    
    
=== drum ===

A snare drum, adorned with the same green spores you found earlier. Its head is battered with faded lines, marking years of use, but the metal wiring and shell remain in impeccable shape.

+ [LISTEN]
    -> drum_song
    
+ [RETURN]
    -> shrine
    
=== drum_song ===

The drum strikes a crisp, lively melody. The shrine thrums to life with each steady beat. Here I am, here I am, it seems to say, joining you in song.

<i> You now have the SHARD of the DRUM.

+ [RETURN]
    -> shrine


=== command ===

The crash has left the command room in a state of disarray, with wires and debris skittering around the floor. The green spores are most abundant here, moving through the space in scattered dance. Phantom sounds echo beneath the static hum of the room.

Through the disorder, you spy the flickering screen of a computer and a closet.

+ [EXAMINE COMPUTER]
    -> computer
    
+ [EXAMINE CLOSET]
    -> closet

+ [EXAMINE SPORES]
    -> spores

+ [LEAVE]
    -> hallway_lvl2

=== computer ===

Miraculously, this computer seems to be just barely in working order. On the screen, you find an archive of various files and conversation logs.

+ [COMMAND LOG 190.30.22XX]
    -> command_log
    
+ [COMMAND LOG 001.97.22XX]
    -> command_log_2

+ [LEAVE]
    -> command
    
=== command_log ===

<b> LOG, COMMAND: 190.30.20XX
CAPTAIN: Okay, okay. I think this is it. I'm going.
MECHANIC: Captain.
CAPTAIN: He's here. Don't you hear him, too?
MECHANIC: We've never scoped out this planet before. We don't know what else is out there. There's strange signals everywhere around us, it could be -
CAPTAIN: This is the closest we've ever gotten. I'm not leaving him again.
MECHANIC: Sir, please.
CAPTAIN: You don't have to come with me, I promise. You can take the ship and leave. It's the least I can do for you, after everything. You should've left with the Medic. Before the Pilot -
MECHANIC: It's not your fault I stayed. We just have to keep moving forward, right?
MECHANIC: Captain?
CAPTAIN: I'm sorry, kid. You'll have to go on without me.

<b> LOG ERROR. CORRUPTED FILE.

+ [LEAVE]
    -> computer
    2
=== command_log_2 ===

<b> LOG, COMMAND: 001.97.20XX
NAVIGATOR: Alright, I've finished training the Mechanic on the general layout of the ship. We can walk them through the engine room once we've sorted out the mess with the water filtration.
CAPTAIN: Copy, sir.
NAVIGATOR: This kinds of tasks should really be your job, you know.
CAPTAIN: What's a Captain without a capable Navigator as their right hand?
NAVIGATOR: Hmph. I think you're just lazy sometimes.
CAPTAIN: See, I like to call it the art of delegation!
CAPTAIN: Anywho, I think we're all due for a little break soon. Maybe we can stop on that one planet? The one with the funky cantina karaoke? That could be fun. We can celebrate the addition of our bright new crew member!
NAVIGATOR: [sighs]
CAPTAIN: C'mon. You can't tell me that doesn't sound fun to you, Mr. I-Sing-In-The-Command-Room-When-I-Think-No-One-Is-Listening.
NAVIGATOR: Please never use that nickname again.
NAVIGATOR: But fine. I agree we've been on the road for longer than usual.
CAPTAIN: Yes! Can't wait to see the kid swoon at the sound of your sweet, dulcet tones.
NAVIGATOR: Before that, though, I'm going to make a quick detour.
CAPTAIN: Oho, what's captured the curiosity of our inscrutable Navigator?
NAVIGATOR: Hmph. I'll tell you about it later. It's getting late.
CAPTAIN: Sure, sure.
NAVIGATOR: One more thing. You need to change your password to the command room's closet.
CAPTAIN: Why?
NAVIGATOR: You really think '1111' is a good password?
CAPTAIN: It's easy to remember. I prefer that over security any day, haha!

<b> END LOG.

+ [LEAVE]
    -> computer

=== closet ===

{not command_log_2: The closet is locked by a 4-digit passcode.}

{command_log_2: The Captain was right! This passcode was easy to remember.}

{command_log_2: Inside is a violin.}

+ {command_log_2} [EXAMINE VIOLIN]
    -> violin

+ [LEAVE]
    -> command

=== violin ===

A violin with no bow. Spores are speckled on its long neck. It seems lonely by itself here. 

+ [LISTEN]
    -> violin_song

+ [LEAVE]
    -> closet
    
=== violin_song ===

The song swells and dances across the strings. You wonder if it's chasing something. You hope one day it'll find what it was looking for. 

+ [LEAVE]
    -> violin
    
=== spores ===

The spores drift lazily through the air, a symphony of murmurs and fragmented echoes. This must be the same species as the phantom flora that seem to 'play' the crew's instruments.

Amid the noise, your etherphone can make out the threads of a distinct voice.

+ [LISTEN]
    -> voice

+ [LEAVE]
    -> command

=== voice ===

The voice emerges from the depths of memory - melodious, evocative, with the shadow of soft laughter. Before it disappears again, you capture it in your etherphone. 

How do you know when something has arrived in your life? When it calls to you, unbidden.

<i> You now have the SHARD of SONG.

+ [LEAVE]
    -> command

=== final_song ===

{flute_song && drum_song && piano_song && violin_song && voice: You listen as the Eurydice performs in song-wed twine, joined together once more. The hum of the tree rises to meet the crew's melodies in full. You wonder if this is what the strange signal had been searching for, too, if this is what drew the Eurydice here, across this lonely stretch of the universe — another voice to answer its call.}

{flute_song && drum_song && piano_song && violin_song && voice: You stand before it all, wreathed in song.}

-> END

