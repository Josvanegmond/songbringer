-> hallway

-> END


= hallway
#music_play:echoes
Apart from the sounds of machinery, the hallway is devoid of life.
+ [to engine #entrance_to engine]
  -> engine
+ [to river #entrance_to river]
  -> river
+ [to machine #entrance_to machine]
  -> machine
+ [scavenge #scavenge_at hallway_1]
  -> engine

= river
The river is flowing briskly.
+ [to hallway #entrance_to hallway]
  -> hallway

= engine
#music_play:silence
The engine generates power.
+ [to hallway #entrance_to hallway]
  -> hallway
+ [to sewers #entrance_to sewers]
  -> sewers


= sewers
The sewers are cold and damp.
+ [to engine #entrance_to engine]
  -> engine


= machine
The machine works tirelessly.
+ [to hallway #entrance_to hallway]
  -> hallway