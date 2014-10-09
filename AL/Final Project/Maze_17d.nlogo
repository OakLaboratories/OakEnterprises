; Extensions
extensions [bitmap]
extensions [sound]
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Breeds and Variables
globals [ major_state text text_state win? map-on? movement power-up-state level change? restart]
breed [players player]
breed [enemies enemy]
breed [bosses boss]
breed [powerUps powerUp]

players-own [health speed strength]
enemies-own [species health speed strength age] ; "fast" "strong" "long-range"
bosses-own [health]
patches-own [state walk]
powerUps-own [function]
;-------------------------------------------------------------------------------------------------------------------------------------------------------
;Reporters
to-report my_health
  report [health] of player 0
end
to-report messages
  report text
end


;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Show Map
to show_map
  if map-on? = false [
    reset-timer
    import-pcolors "Map 8.png" 
    wait 2 
    ask patches [set pcolor white] 
    ask patch 12 9 [set pcolor 16.6]
    ask patch -12 -11 [set pcolor 72.5]
    set map-on? true
    ask enemies with [species = "fast"] [set shape one-of ["pterodactyl" "centaur" "viking"]]
    ask enemies with [species = "strong"] [set shape one-of ["st tiger" "cyclops" "troll"]]
    ask enemies with [species = "long-range"] [set shape one-of ["neanderthal" "medusa" "dark elf"]]
    ask players [set shape one-of ["cavemen" "spartan" "knight"]]
  ]
  ifelse timer > 25
    [set map-on? false]
    [set map-on? true]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Basic Player Functions
to direction [degree colour]
  set heading degree
  
  if [pcolor] of patch-ahead 1 = colour or [pcolor] of patch-ahead 1 = 72.5 or [walk] of patch-ahead 1 = "pathway" [fd speed]
end

to direction-boss [degree colour]
  set heading degree
  if [pcolor] of patch-ahead 1 = colour or [pcolor] of patch-ahead 1 = blue [fd speed]
end

to attack_fast
  let x enemies in-radius 3 with [species = "strong"]
  if any? x [
    ask min-one-of x [distance myself] [set health health - 4 * [strength] of myself]
  ]
  let y enemies in-radius 3 with [species = "fast"]
  if any? y [
    ask min-one-of y [distance myself] [set health health - 2 * [strength] of myself]
  ]
  let z enemies in-radius 3 with [species = "long-range"]
  if any? z [
    ask min-one-of z [distance myself] [set health health - 1 * [strength] of myself]
  ]
end

to attack_strong
  let x enemies in-radius 3 with [species = "long-range"]
  if any? x [
    ask min-one-of x [distance myself] [set health health - 8 * [strength] of myself]
  ]
  let y enemies in-radius 3 with [species = "strong"]
  if any? y [
    ask min-one-of y [distance myself] [set health health - 4 * [strength] of myself]
  ]
  let z enemies in-radius 3 with [species = "fast"]
  if any? z [
    ask min-one-of z [distance myself] [set health health - 2 * [strength] of myself]
  ]
end

to attack_long-range
  let x enemies in-radius 5 with [species = "fast"]
  if any? x [
    ask min-one-of x [distance myself] [set health health - 4 * [strength] of myself]
  ]
  let y enemies in-radius 5 with [species = "long-range"]
  if any? y [
    ask min-one-of y [distance myself] [set health health - 2 * [strength] of myself]
  ]
  let z enemies in-radius 5 with [species = "strong"]
  if any? z [
    ask min-one-of z [distance myself] [set health health - 1 * [strength] of myself]
  ]
end

to health_check
  ask players [if not any? enemies in-radius 3 and health < 100 [set health health + .1]]
  ask players [if health < 4 [die]]
  if count players = 0 [
    wait 2
    set restart true
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Basic Power-ups Functions
to create-power-ups
  if power-up-state < 4 [
    if 1 > random 20 [
      ask one-of patches with [ walk = "pathway" or pcolor = 16.6] [
        sprout 1 [
          set breed powerUps
          set function one-of ["health"  "strength"]
        ]
      ]
    ]
    set power-up-state power-up-state + 1
  ]
  ask powerUps with [function = "strength"] [set shape "box" set size 2 set color yellow]
  ask powerUps with [function = "health"] [set shape "box" set size 2 set color blue]
;  ask powerUps with [function = "speed"] [set shape "box" set size 1 set color green]
end

to powerups?
    ask players [
    if any? powerUps-here with [function = "health"] [
      reset-timer
      set health 100
      set color blue
      set size 5
      wait .5
      set size 1
      ask powerUps [die]
    ]
  ]
  ask players [
    if any? powerUps-here with [function = "strength"] [
      reset-timer
      set strength 2
      set color yellow
      set size 5
      wait .5
      set size 1
      ask powerUps [die]
    ]
  ]
  ask players [
    if any? powerUps-here with [function = "speed"] [
      reset-timer
      set speed 2
      set color green
      set size 5
      wait .5
      set size 1
      ask powerUps [die]
    ]
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Basic Enemy Functions
to fast_enemy_setup
  set speed 2
  set strength 5
  set health 15
  set age "old"
end

to fast_enemy_go
  if any? players in-radius 5 [
    face player 0
    ifelse any? players in-radius 3 [fd 1] [fd speed]
    rt random 30
    lt random 30
  ] 
  if any? players-here [
    ask players [
      set health health - [strength] of myself
    ]
  ]
end

to strong_enemy_setup
  set speed .5
  set strength 10
  set health 20
  set age "old"
end

to strong_enemy_go
  if any? players in-radius 3 [
    face player 0
    fd speed
    rt random 15
    lt random 15
   
  ] 
  if any? players-here [
    ask players [
      set health health - [strength] of myself
    ]
  ]
end

to long-range_enemy_setup
  set speed 1
  set strength 3
  set health 15
  set age "old"
end

to long-range_enemy_go
  if any? players in-radius 10 and not any? players in-radius 3[
    face player 0
    fd speed
    rt random 30
    lt random 30
  ]
  if any? players in-radius 2[
    face player 0
    bk speed
    rt random 30
    lt random 30
  ]
  if any? players in-radius 3 [
    ask players [
      set health health - [strength] of myself
    ]
  ]
end

to random_enemies
  if any? patches with [walk = "pathway" or pcolor = 16.6] [
  ask one-of patches with [walk = "pathway" or pcolor = 16.6] [
    if random 20 < 1 [
      sprout 1 [
        set breed enemies
        set species one-of ["fast" "strong" "long-range"]
        set age "young"
      ]
    ]
  ]
  ask enemies with [species = "fast" and age = "young"] [fast_enemy_setup]
  ask enemies with [species = "strong" and age = "young"] [strong_enemy_setup]
  ask enemies with [species = "long-range" and age = "young"] [long-range_enemy_setup]
  ask enemies [set age "old"]
  if level = 8 [ask enemies [set shape "glitch"]]
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Setup and Go - BC
to setup_BC
  ;Map Setup
  ca
  set text "    "
  set text_state 0
  set movement "normal"
  set level 1
  import-pcolors "Map 1.png"
  ask patch 11 -12 [set pcolor 72.5]
  ask patches with [pcolor != 16.6 and pcolor != 72.5] [set pcolor one-of [68 49]]
  ask patch -11 12 [set pcolor one-of [68 49]]
  set power-up-state 0
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -11 11
    set shape "cavemen"
    set color 28
    set heading 90
    set strength 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
     while [pcolor != 16.6] [setxy random-xcor random-ycor]
     set color black
     ]
   ask enemies with [species = "fast"] [
     set shape "pterodactyl"
     fast_enemy_setup
   ]
   ask enemies with [species = "long-range"] [
     set shape "neanderthal"
     long-range_enemy_setup
   ]
   ask enemies with [species = "strong"] [
     set shape "st tiger"
     strong_enemy_setup
   ]
   ;Tree Decoration setup
   ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "tree"
       set color 53
       set size 2
       set heading 0
       fd 1
       ]
   ]
end

to go_BC
  ;Power-ups
  
  while [text_state = 0 ] [
  set text "Our young hero has transported himself back in time..."
  wait 6
  set text "in an attempt to root out all evil in the universe."
  wait 5
  set text "Help him complete his mission by steering him through each maze."
  wait 5
  set text "Ready..."
  wait 4
  set text "Go!"
  wait 1
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  random_enemies
  ask enemies with [species = "fast"] [set shape "pterodactyl" set color black]
  ask enemies with [species = "strong"] [set shape "st tiger"]
  ask enemies with [species = "long-range"] [set shape "neanderthal"]
  ;Players
  health_check
  if restart = true [
    setup_BC 
    set restart false
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Setup and Go - Greece
to setup_2
  ;Map Setup
  ca
  set text_state 0
  set movement "normal"
  set text "    "
  import-pcolors "Map 2.png"
  ask patches with [pcolor = 14.9] [set pcolor 16.6]
  ask patch -1 -1 [set pcolor 72.5]
  ask patches with [pcolor != 16.6 and pcolor != 72.5] [set pcolor one-of [49 98.5]]
  set power-up-state 0
  set level 2
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -1 1
    set shape "spartan"
    set color 28
    set heading 90
    set strength 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
     while [pcolor != 16.6] [setxy random-xcor random-ycor]
     set color black
     ]
   ask enemies with [species = "fast"] [
     set shape "centaur"
     fast_enemy_setup
   ]
   ask enemies with [species = "long-range"] [
     set shape "medusa"
     long-range_enemy_setup
   ]
   ask enemies with [species = "strong"] [
     set shape "cyclops"
     strong_enemy_setup
   ]
   ;Column Decoration setup
   ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "column"
       set color grey
       set size 2
       set heading 0
       fd 1
       ]
   ]
end

to go_2
  ;Power-ups
   while [text_state = 0 ] [
  set text "Great Work!"
  wait 6
  set text "Too bad you're stuck in Ancient Greece..."
  wait 5
  set text "Ready..."
  wait 4
  set text "Go!"
  set text_state 1 ]
   
  set text "Remember this: R G Y B"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  random_enemies
  ask enemies with [species = "fast"] [set shape "centaur"]
  ask enemies with [species = "strong"] [set shape "cyclops"]
  ask enemies with [species = "long-range"] [set shape "medusa"]
  ;Players
  health_check
  if restart = true [
    setup_2
    set restart false
  ]
  ask players [if [pcolor] of patch-here = 72.5 [set level 7]]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Setup and Go - Medieval
to setup_3
  ;Map Setup
  ca
  set movement "normal"
  set text_state 0
  set text "    "
  import-pcolors "Map 3.png"
  ask patches with [pcolor = 14.9] [set pcolor 16.6]
  ask patch 11 11 [set pcolor 72.5]
  ask patches with [pcolor != 16.6 and pcolor != 72.5] [set pcolor one-of [49 98.5]]
  set power-up-state 0
  set level 3
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -11 -11
    set shape "knight"
    set color 28
    set heading 90
    set strength 1
    set speed 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
     while [pcolor != 16.6] [setxy random-xcor random-ycor]
     ]
   ask enemies with [species = "fast"] [
     set shape "viking"
     fast_enemy_setup
   ]
   ask enemies with [species = "long-range"] [
     set shape "dark elf"
     long-range_enemy_setup
   ]
   ask enemies with [species = "strong"] [
     set shape "troll"
     strong_enemy_setup
   ]
   ;Decoration setup
   ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "tower" 
       set color black 
       set size 2
       set heading 0
       fd 1
       ]
   ]
end

to go_3
  ;Power-ups
    while [text_state = 0 ] [
  set text "What's this?!!...  Giant chess pieces?"
  wait 6
  set text "This must be the middle ages.  I wonder where the King is."
  wait 5
  set text "Ready..."
  wait 2
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  repeat level [random_enemies]
  ask enemies with [species = "fast"] [set shape "troll"]
  ask enemies with [species = "strong"] [set shape "viking"]
  ask enemies with [species = "long-range"] [set shape "dark elf"]
  ;Players
  health_check
  if restart = true [
    setup_3
    set restart false
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Setup and Go - Industrialization
to setup_4
  ;Map Setup
  ca
  set movement "normal"
  set text_state 0
  set text "    "
  import-pcolors "Map 4.png"
  ask patches with [pcolor = white] [set pcolor 16.6]
  ask patch 11 11 [set pcolor 72.5]
  ask patches with [pcolor != 16.6 and pcolor != 72.5] [set pcolor one-of [35.5 37.5]]
  set power-up-state 0
  set level 4
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -11 -11
    set shape "worker"
    set color 28
    set heading 90
    set strength 1
    set speed 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
     while [pcolor != 16.6] [setxy random-xcor random-ycor]
     ]
   ask enemies with [species = "fast"] [
     set shape "bartender"
     fast_enemy_setup
     set color 28
   ]
   ask enemies with [species = "long-range"] [
     set shape "general"
     long-range_enemy_setup
     set color green
   ]
   ask enemies with [species = "strong"] [
     set shape "capitalist"
     strong_enemy_setup
     set color 28
   ]
   ;Decoration setup
   ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "factory" 
       set color grey 
       set size 2
       set heading 0
       fd 1
       ]
   ]
end

to go_4
  ;Power-ups
    while [text_state = 0 ] [
  set text "Eww.  Factories, smoke stacks, peasant laborers..."
  wait 6
  set text "It's the Industrial Age in Europe"
  wait 5
  set text "Maybe this is what China looks like today"
  wait 5
  set text "I'm never going there..."
  wait 4
  set text "Ready..."
  wait 2
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  repeat level [random_enemies]
  ask enemies with [species = "fast"] [set shape "bartender" set color 28]
  ask enemies with [species = "strong"] [set shape "capitalist" set color 28]
  ask enemies with [species = "long-range"] [set shape "general" set color green]
  ;Players
  health_check
  if restart = true [
    setup_4
    set restart false
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Setup and Go - Modern day
to setup_5
  ;Map Setup
  ca
  set movement "normal"
  set text_state 0
  set text "    "
  import-pcolors "Map 5.png"
  ask patches with [pcolor = white] [set pcolor 16.6]
  ask patch 11 11 [set pcolor 72.5]
  ask patches with [pcolor != 16.6 and pcolor != 72.5] [set pcolor one-of [4 34]]
  set power-up-state 0
  set level 5
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -11 -11
    set shape "student"
    set color 28
    set heading 90
    set strength 1
    set speed 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
     while [pcolor != 16.6] [setxy random-xcor random-ycor]
     ]
   ask enemies with [species = "fast"] [
     set shape "skateboarder"
     fast_enemy_setup
     set color 28
   ]
   ask enemies with [species = "long-range"] [
     set shape "thug"
     long-range_enemy_setup
     set color green
   ]
   ask enemies with [species = "strong"] [
     set shape "homeless"
     strong_enemy_setup
     set color 28
   ]
   ;Decoration setup
   ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "store" 
       set color grey 
       set size 2
       set heading 0
       fd 1
       ]
   ]
end

to go_5
  ;Power-ups
    while [text_state = 0 ] [
  set text "Ahh, finally home, in a world of McDonalds and Burger King "
  wait 6
  set text "But I still haven't found the real source of the world's problems."
  wait 5
  set text "Of course, why would it live in the present, when it could live safely in..."
  wait 5
  set text "...the future"
  wait 4
  set text "But until then, how about a Hamburger?"
  wait 2
  set text "Ready..."
  wait 2
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  repeat level [random_enemies]
  ask enemies with [species = "fast"] [set shape "skateboarder"]
  ask enemies with [species = "strong"] [set shape "homeless"]
  ask enemies with [species = "long-range"] [set shape "thug"]
  ;Players
  health_check
  if restart = true [
    setup_5
    set restart false
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
to setup_6
  ;Map Setup
  ca
  set movement "normal"
  set text "    "
  set text_state 0
  set level 6
  import-pcolors "Map 6.png"
  ask patch 11 -11 [set pcolor 72.5]
  ask patches with [pcolor = 9.9] [set walk "pathway" set pcolor 16.6]
  ask patches with [pcolor != 16.6 and pcolor != 72.5] [set pcolor one-of [12 15]]
  ask patch -11 12 [set pcolor one-of [12 15]]
  set power-up-state 0
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -11 11
    set shape "survivor"
    set color 28
    set heading 90
    set strength 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
     while [pcolor != 16.6] [setxy random-xcor random-ycor]
     set color black
     ]
   ask enemies with [species = "fast"] [
     set shape "ufo side"
     fast_enemy_setup
   ]
   ask enemies with [species = "long-range"] [
     set shape "alien"
     set color green
     long-range_enemy_setup
   ]
   ask enemies with [species = "strong"] [
     set shape "zombie"
     strong_enemy_setup
   ]
   ;Bud Decoration setup
   ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "bud"
       set color one-of [red black]
       set size 2
       set heading 0
       fd 1
       ]
   ]
end

to go_6
  ;Power-ups
   while [text_state = 0 ] [
  set text "Ugh, it looks like the world has been destroyed!  But by whom..."
  wait 6
  set text "It certainly wasn't the humans who did this!"
  wait 5
  set text "I can't believe I survived the apocolypse."
  wait 5
  set text "Let's see who else is around..."
  wait 4
  set text "Ready..."
  wait 2
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  random_enemies
  ask enemies with [species = "fast"] [set shape "ufo side"]
  ask enemies with [species = "strong"] [set shape "zombie"]
  ask enemies with [species = "long-range"] [set shape "alien"]
  ;Players
  health_check
  if restart = true [
    setup_6
    set restart false
  ]
end
;------------------------------------------------------------------------------------------------------------------------------------------------------------
; Setup abd Go - Level 7
to setup_7
  ;Map Setup
  ca
  set win? 0
  set movement "normal"
  set text "    "
  set text_state 0
  import-pcolors "Map 7.png"
  ask patch -11 1 [set pcolor 16.6 set walk "pathway"]
  ask patch 11 -1 [set pcolor red set walk "pathway"]
  ask patch -11 11 [set pcolor green set walk "pathway"]
  ask patch 11 11  [set pcolor yellow set walk "pathway"]
  ask patch -5 3 [set pcolor blue set walk "pathway"]
  ask patches with [pcolor = 9.9] [set pcolor grey set walk "pathway"]
  ask patch 12 1 [set pcolor 72.5]
 
  ask patches with [pcolor = 104.7 or pcolor = 102.3] [set pcolor one-of [7 9]]
  ask patch -12 11 [set walk "x"]
  ask patch -12 1 [set walk "x"]
  ask patch 12 11 [set walk "x"]
  set power-up-state 0
  set level 7
  ;Player Setup
  create-players 1 [
    set health 100
    setxy -11 1
    set shape "cyborg"
    set color 2.5
    set heading 90
    set strength 1
    set speed 1
    ]
  ;Enemy Setup
   create-enemies 6 [
    set species one-of ["fast" "strong" "long-range"]
     while [pcolor != grey] [setxy random-xcor random-ycor]
     set color black
     ]
   ask enemies with [species = "fast"] [
     set shape "robot"
     fast_enemy_setup
   ]
   ask enemies with [species = "long-range"] [
     set shape "elderly"
     long-range_enemy_setup
   ]
   ask enemies with [species = "strong"] [
     set shape "terminator"
     strong_enemy_setup
   ]
   ;Column Decoration setup
  ask n-of 7 patches with [pcolor != 16.6] [
     sprout 1 [
       set shape "column"
       set color grey
       set size 2
       set heading 0
       fd 1
      ]
   ]
end

to go_7
  ;Power-ups
   while [text_state = 0 ] [
  set text "What's this?!! A future of chrome?"
  wait 6
  set text "Where is the end of the path?!!"
  wait 5
  set text "There's no way through!"
  wait 5
  set text "Maybe the answer lies in the past."
  wait 4
  set text "I hope you remember..."
  wait 4
  set text "Ready..."
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 2.5 set size 1]
    ask players [set strength 1 set color 2.5 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  random_enemies
  ask enemies with [species = "fast"] [set shape "robot"]
  ask enemies with [species = "strong"] [set shape "terminator"]
  ask enemies with [species = "long-range"] [set shape "elderly"]
  ;Players
  ask players [if [pcolor] of patch-here = red and win? = 0 [sound:play-note "TRUMPET" 60 64 1 set win? 1]]
  ask players [if [pcolor] of patch-here = green and win? = 1 [sound:play-note "TRUMPET" 60 64 2 set win? 2]]
  ask players [if [pcolor] of patch-here = yellow and win? = 2 [sound:play-note "TRUMPET" 60 64 2 set win? 3]]
  ask players [if [pcolor] of patch-here = blue and win? = 3 [ sound:play-note "TRUMPET" 60 64 2 set win? 4]]
  
  ask players [if win? = 4 [setxy 11 1 ]]
  
  health_check
  if restart = true [
    setup_7
    set restart false
  ]
  ask players [if [pcolor] of patch-here = 72.5 [set level 8]]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------
; Setup and Go - Level 8
to setup_8
  ca
  set level 8
  set text "    "
  set text_state 0
  set map-on? "true"
  import-pcolors "Map 8.png"
  ask patches with [pcolor = 9.9] [set walk "pathway"]
  ask patches [set pcolor white]
  ask patch 11 9 [set pcolor 16.6]
  ask patch 12 9 [set walk "x"]
  ask patch -12 -11 [set pcolor 72.5]
  ask patches with [pxcor = 12 or pycor = 12 and pcolor != 72.5] [set walk "x"]
  ;Player Setup
  create-players 1 [
    set health 100
    setxy 11 9
    set shape "cavemen"
    set color 28
    set heading 90
    set strength 1
    set speed 1
    ]
  ;Enemy Setup
   create-enemies 6 [
     set species one-of ["fast" "strong" "long-range"]
      ask enemies [setxy random-xcor random-ycor]
     set color black
     ]
   ask enemies with [species = "fast"] [
     set shape "pterodactyl"
     fast_enemy_setup
   ]
   ask enemies with [species = "long-range"] [
     set shape "neanderthal"
     long-range_enemy_setup
   ]
   ask enemies with [species = "strong"] [
     set shape "st tiger"
     strong_enemy_setup
   ]
end

to go_8
  ;Power-ups
   while [text_state = 0 ] [
  set text "What?!! Where is the map?"
  wait 6
  set text "I can't see!"
  wait 5
  set text "This could have only been done by the most evil of forces."
  wait 5
  set text "But it's impossible to make the world permanently white."
  wait 5
  set text "There must be a glitch somewhere..."
  wait 5
  set text "Ready..."
  wait .5
  set text_state 1 ]
  set text "No more for now"
  create-power-ups
  if timer > 20 [
    ask players [set speed 1 set color 28 set size 1]
    ask players [set strength 1 set color 28 set size 1]
  ]
  if timer < 20 [ask players with [state = "health" ] [set health 100]]
  ask players [powerups?]
  ;Enemies
  ask enemies with [species = "fast"] [fast_enemy_go]
  ask enemies with [species = "strong"] [strong_enemy_go]
  ask enemies with [species = "long-range"] [long-range_enemy_go]
  ask enemies [if health < 3 [die]]
  random_enemies
  ask enemies with [species = "fast" and age = "young"] [set shape one-of ["pterodactyl" "centaur" "viking"]]
  ask enemies with [species = "strong" and age = "young"] [set shape one-of ["st tiger" "cyclops" "troll"]]
  ask enemies with [species = "long-range" and age = "young"] [set shape one-of ["neanderthal" "medusa" "dark elf"]]
  show_map
  ;Players
  health_check
  if restart = true [
    setup_8
    set restart false
  ]
end
;-------------------------------------------------------------------------------------------------------------------------------------------------------
;Complete Go + Setup
to setup
  ca
  set text "Push Play to Play"
  import-drawing "coverphoto.png"
  wait 5
  setup_BC
end

to go
  ask players [if pcolor = 72.5 [
      set level level + 1
      set change? true]]
  if level = 1 [go_BC]
  wait .02
  if level = 2 and change? = true [
    setup_2
    set change? false
  ]
  if level = 2 [go_2]
  wait .02
  if level = 3 and change? = true [
    setup_3
    set change? false
  ]
  if level = 3 [go_3]
  wait .02
  if level = 4 and change? = true [
    setup_4
    set change? false
  ]
  if level = 4 [go_4]
  wait .02
  if level = 5 and change? = true [
    setup_5
    set change? false
  ]
  if level = 5 [go_5]
  wait .02
  if level = 6 and change? = true [
    setup_6
    set change? false
  ]
  if level = 6 [go_6]
  wait .02
  
  if level = 7 and change? = true [
    setup_7
    set change? false
  ]
  if level = 7 [go_7]
  wait .02
  if level = 8 and change? = true [
    setup_8
    set change? false
  ]
  if level = 8 [go_8]
  wait .02
  
end
;------------------------------------------------------------------------------------------------------------------------------------------------------
;Bosses
to setup-tRex-boss
  sound:play-sound "junglemusic.wav"
  ca
  set power-up-state "0"
  set movement "boss"
  ask patches [set pcolor blue]
   create-players 1 [
    set health 100
    set shape "cavemen"
    set color 28
    set size 2
    set heading 90
    set speed 2
    ]
  create-bosses 1 [set health 300 set shape "turtle" set size 6 setxy 0 0]
  ask n-of 6 patches [set state "human-health"]
  ask n-of 6 patches [set state "trex-health"]
  ask one-of patches [set state "bad-human-health"]
  ask enemies with [species = "fast"] [fast_enemy_setup]
end

to play-tRex-boss
  ask patches [set pcolor blue]
  ask players [if [state] of patch-here = "human-health" [set health health + 20]
    if [state] of patch-here = "trex-health" [ask enemies [set health health + 20]]
    if [state] of patch-here = "bad-human-health"  [set health health - 40 ask patch-here [ask neighbors [set pcolor red wait .5  set pcolor black]]]
   
    ]
  ask enemies [ ask patches in-cone 4 40 [set pcolor orange] ]
  ask enemies [if any? players 
    
     [
    face min-one-of players [distance myself] fd .5 wait .1 if any? players-here [ask players-here [set health health - 10] face min-one-of players [distance myself] rt 180 bk 3]]
  ]
    ask players [if health < 20 [die]]
    ask enemies [if health < 3 [die]]
end
@#$#@#$#@
GRAPHICS-WINDOW
207
67
762
643
12
12
21.8
1
10
1
1
1
0
0
0
1
-12
12
-12
12
0
0
1
ticks
30.0

BUTTON
14
153
119
186
Setup
setup 
NIL
1
T
OBSERVER
NIL
2
NIL
NIL
1

BUTTON
13
387
76
420
Left
ask players [direction 270 16.6]
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
139
387
202
420
Right
ask players [direction 90 16.6]
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
77
355
140
388
Up
ask players [direction 0 16.6]
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
76
387
139
420
Down
ask players [direction 180 16.6]
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
14
188
119
221
Play!
go
T
1
T
OBSERVER
NIL
P
NIL
NIL
1

BUTTON
46
449
176
482
Attack Fast!
ask players [attack_fast]
NIL
1
T
OBSERVER
NIL
J
NIL
NIL
1

BUTTON
46
481
176
514
Attack Strong!
ask players [attack_strong]
NIL
1
T
OBSERVER
NIL
K
NIL
NIL
1

BUTTON
46
514
176
547
Attack Long-Range!
ask players [attack_long-range]
NIL
1
T
OBSERVER
NIL
L
NIL
NIL
1

MONITOR
15
224
119
269
Life
my_health
0
1
11

MONITOR
207
10
762
67
Messages
messages
17
1
14

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

alien
false
0
Polygon -7500403 true true 150 15 120 30 120 45 120 75 144 81 127 96 129 113 144 134 136 185 135 195 120 195 135 195 150 180 165 195 165 184 157 134 170 115 173 95 156 81 180 75 181 42 180 30
Polygon -7500403 true true 150 167 159 185 190 182 225 212 255 257 240 212 200 170 154 172
Polygon -7500403 true true 161 167 201 150 237 149 281 182 245 140 202 137 158 154
Polygon -7500403 true true 155 135 185 120 230 105 270 135 233 115 201 124 155 150
Polygon -7500403 true true 145 135 115 120 70 105 30 135 67 115 99 124 145 150
Polygon -7500403 true true 139 167 105 165 75 180 45 225 60 165 105 150 142 154
Polygon -7500403 true true 150 167 141 185 110 182 75 212 45 257 60 212 100 170 146 172
Circle -16777216 true false 126 35 15
Circle -16777216 true false 157 35 15

bartender
false
0
Polygon -7500403 true true 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -1 true false 120 90 105 90 60 195 90 210 120 150 120 195 180 195 180 150 210 210 240 195 195 90 180 90 165 105 150 165 135 105 120 90
Polygon -1 true false 123 90 149 141 177 90
Rectangle -7500403 true true 123 76 176 92
Circle -7500403 true true 110 5 80
Line -13345367 false 121 90 194 90
Line -16777216 false 148 143 150 196
Rectangle -16777216 true false 116 186 182 198
Circle -1 true false 152 143 9
Circle -1 true false 152 166 9
Rectangle -16777216 true false 179 164 183 186
Polygon -2674135 true false 180 90 195 90 183 160 180 195 150 195 150 135 180 90
Polygon -2674135 true false 120 90 105 90 114 161 120 195 150 195 150 135 120 90
Polygon -2674135 true false 145 91 172 77 172 101
Polygon -2674135 true false 155 91 128 77 128 101
Rectangle -955883 true false 251 162 281 207
Polygon -1184463 true false 250 171 241 172 241 181 241 193 245 198 248 201 250 197 246 193 246 178 249 177
Circle -1 true false 251 154 10
Circle -1 true false 258 153 10
Circle -1 true false 265 154 10
Circle -1 true false 270 154 10
Line -16777216 false 255 210 255 165
Line -16777216 false 270 210 270 165
Line -16777216 false 263 210 263 165

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bud
false
0
Polygon -7500403 true true 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Polygon -7500403 true true 189 233 219 188 249 173 279 188 234 218
Polygon -7500403 true true 180 255 150 210 105 210 75 240 135 240
Polygon -7500403 true true 180 150 180 120 165 97 135 84 128 121 147 148 165 165
Polygon -7500403 true true 170 155 131 163 175 167 196 136

capitalist
false
0
Rectangle -1 true false 120 90 180 180
Polygon -13345367 true false 135 90 150 105 135 180 150 195 165 180 150 105 165 90
Polygon -14835848 true false 120 88 105 88 60 193 90 208 116 152 109 177 90 283 105 298 135 298 150 223 165 298 195 298 210 283 194 183 183 151 210 208 240 193 195 88 180 88 150 163
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 76 172 91
Line -16777216 false 172 90 161 94
Line -16777216 false 128 90 139 94
Polygon -6459832 true false 195 227 195 302 270 272 270 197
Rectangle -16777216 true false 180 226 195 301
Polygon -16777216 true false 209 202 209 216 244 202 243 188
Line -16777216 false 180 90 150 165
Line -16777216 false 120 90 150 165
Polygon -6459832 true false 107 194 90 284 105 300 138 300 151 227 164 300 180 299 180 224 200 219 195 194
Polygon -16777216 true false 180 226 195 226 270 196 255 196
Rectangle -16777216 true false 106 18 189 39
Rectangle -16777216 true false 120 -13 180 20
Polygon -1184463 true false 247 227 232 234 233 241 243 249 247 261 241 270 228 280 228 273 233 267 238 260 238 253 234 251 231 245 227 230 234 223 245 222
Rectangle -1184463 true false 235 210 239 282

cavemen
false
13
Circle -2064490 true true 110 20 80
Polygon -2064490 true true 108 89 123 194 93 299 108 299 138 299 153 224 168 299 198 299 213 299 183 194 198 89
Rectangle -7500403 true false 135 75 172 94
Polygon -2064490 true true 195 90 254 157 225 180 165 105
Polygon -2064490 true true 105 90 45 154 75 180 135 105
Polygon -6459832 true false 105 60 195 60 180 120 135 120 105 60
Line -2064490 true 150 225 165 225
Polygon -6459832 true false 120 45 105 45 195 45 180 15 120 15 105 45
Polygon -6459832 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -10899396 true false 145 203 137 221 145 221 143 237 150 233 152 246 156 234 159 236 155 226 154 222 170 225 153 204 149 198 146 206
Polygon -2064490 true true 149 72 183 72 167 88 149 89 137 71 152 71
Line -6459832 false 147 76 171 78

centaur
false
0
Polygon -6459832 true false 200 253 197 309 179 309 177 256 166 247 140 249 93 251 78 239 72 271 49 269 48 241 37 209 25 180 25 149 45 132 103 144 180 135 180 75 195 45 225 90 240 120 240 180 240 210 224 227
Polygon -6459832 true false 73 270 86 311 62 309 48 268
Polygon -6459832 true false 25 159 16 240 9 249 23 258 25 245 39 168
Circle -1184463 true false 191 30 60
Polygon -1184463 true false 180 135 240 210 240 120 225 90 195 45 180 75 180 135
Circle -16777216 true false 228 42 10
Polygon -16777216 true false 213 37 184 64 180 93 180 119 178 142 160 143 141 143 144 137 158 134 167 133 172 129 172 120 174 114 175 97 175 88 175 77 177 72 177 70 180 61 182 58 182 53 184 51 189 48 190 45 195 34 198 33 201 32 211 32
Line -16777216 false 221 37 234 41
Circle -2064490 true false 225 116 8

column
false
0
Rectangle -7500403 true true 90 90 210 270
Polygon -1 true false 210 270 255 240 255 60 210 90
Polygon -13345367 true false 90 90 45 60 45 240 90 270
Polygon -11221820 true false 45 60 90 30 210 30 255 60 210 90 90 90

cyborg
false
0
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -13345367 true false 135 90 150 105 135 135 150 150 165 135 150 105 165 90
Polygon -7500403 true true 105 90 60 195 90 210 135 105
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -16777216 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 196 90 151 149
Line -16777216 false 104 90 149 149
Circle -7500403 true true 52 200 30
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150
Circle -16777216 true false 149 27 10
Circle -2674135 true false 166 27 12
Circle -7500403 true true 216 201 30
Line -16777216 false 142 61 187 61

cyclops
false
0
Polygon -955883 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 60 195 90 210 114 154 120 195 180 195 187 157 210 210 240 195 195 90 165 90 150 105 150 150 135 90 105 90
Circle -955883 true false 110 5 80
Rectangle -955883 true false 127 79 172 94
Polygon -13345367 true false 120 90 120 180 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 180 90 172 89 165 135 135 135 127 90
Line -16777216 false 225 90 270 90
Line -16777216 false 225 15 225 90
Line -16777216 false 270 15 270 90
Line -16777216 false 247 15 247 90
Rectangle -6459832 true false 240 90 255 300
Circle -1 true false 129 21 42
Circle -7500403 true true 134 27 31
Circle -1 true false 139 32 21
Circle -16777216 true false 142 36 14
Polygon -6459832 true false 116 4 113 21 71 33 71 40 109 48 117 34 144 27 180 26 188 36 224 23 222 14 178 16 167 0

dark elf
false
0
Polygon -1 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -8630108 true false 60 196 90 211 114 155 120 196 180 196 187 158 210 211 240 196 195 91 165 91 150 106 150 135 135 91 105 91
Circle -1 true false 110 5 80
Rectangle -1 true false 127 79 172 94
Polygon -6459832 true false 174 90 181 90 180 195 165 195
Polygon -14835848 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -6459832 true false 126 90 119 90 120 195 135 195
Rectangle -6459832 true false 45 180 255 195
Polygon -16777216 true false 255 165 255 195 240 225 255 240 285 240 300 225 285 195 285 165
Line -16777216 false 135 165 165 165
Line -16777216 false 135 135 165 135
Line -16777216 false 90 135 120 135
Line -16777216 false 105 120 120 120
Line -16777216 false 180 120 195 120
Line -16777216 false 180 135 210 135
Line -16777216 false 90 150 105 165
Line -16777216 false 225 165 210 180
Line -16777216 false 75 165 90 180
Line -16777216 false 210 150 195 165
Line -16777216 false 180 105 210 180
Line -16777216 false 120 105 90 180
Line -16777216 false 150 135 150 165
Circle -16777216 true false 128 32 12
Circle -16777216 true false 160 32 12
Polygon -8630108 true false 100 30 104 44 189 24 185 10 173 10 166 1 138 -1 111 3 109 28

elderly
false
3
Polygon -6459832 true true 199 93 237 183 222 177 169 108
Circle -6459832 true true 110 20 80
Polygon -16777216 true false 107 91 122 196 92 301 107 301 137 301 152 226 167 301 197 301 212 301 182 196 197 91
Rectangle -7500403 true false 135 75 172 94
Polygon -7500403 true false 105 60 195 60 180 120 135 120 105 60
Polygon -7500403 true false 119 45 104 45 194 45 179 15 119 15 104 45
Polygon -1 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -6459832 true true 149 72 183 72 167 88 149 89 137 71 152 71
Line -2064490 false 147 76 171 78
Polygon -6459832 true true 105 90 67 180 82 174 135 105
Circle -7500403 false false 132 90 16
Circle -7500403 false false 138 94 16
Circle -7500403 false false 150 95 16
Circle -7500403 false false 161 21 16
Circle -7500403 false false 154 20 10
Polygon -13791810 true false 123 195 183 195 212 300 169 300 152 224 138 299 92 300
Polygon -7500403 true false 254 198 250 188 242 185 237 181 230 183 229 198 226 214 227 224 228 241 230 257 230 275 228 290 233 298 241 295 241 289 240 272 237 245 237 226 239 212 239 200 239 194 241 194 248 196 250 203 256 207 257 204

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fly 
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

general
false
0
Rectangle -2064490 true false 127 79 172 94
Polygon -10899396 true false 105 90 60 195 90 210 135 105
Polygon -10899396 true false 195 90 240 195 210 210 165 105
Circle -2064490 true false 110 5 80
Polygon -10899396 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -6459832 true false 120 193 180 201
Polygon -7500403 true true 122 4 107 16 102 39 105 53 148 34 192 27 189 17 172 2 145 0
Polygon -16777216 true false 183 90 240 15 247 22 193 90
Rectangle -6459832 true false 114 187 128 208
Rectangle -6459832 true false 177 187 191 208
Circle -1184463 true false 169 108 8
Circle -1184463 true false 157 107 8
Circle -1184463 true false 169 119 8
Circle -1184463 true false 158 119 8
Rectangle -2674135 true false 156 102 178 107
Rectangle -13345367 true false 155 97 177 102
Rectangle -1184463 true false 156 93 178 98
Polygon -1184463 true false 140 2 132 33 152 10 128 11 152 30

glitch
false
0
Rectangle -2674135 true false 75 60 90 90
Rectangle -13791810 true false 120 60 165 150
Rectangle -13840069 true false 150 150 195 165
Rectangle -6459832 true false 30 195 150 240
Rectangle -14835848 true false 105 135 135 195
Rectangle -7500403 true true 60 180 120 210
Rectangle -8630108 true false 195 105 240 300

homeless
false
3
Polygon -6459832 true true 199 93 237 183 222 177 169 108
Circle -6459832 true true 110 20 80
Polygon -7500403 true false 107 91 122 196 92 301 107 301 137 301 152 226 167 301 197 301 212 301 182 196 197 91
Rectangle -7500403 true false 135 75 172 94
Polygon -16777216 true false 105 60 195 60 180 120 135 120 105 60
Polygon -16777216 true false 119 45 104 45 194 45 179 15 119 15 104 45
Polygon -16777216 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -6459832 true true 149 72 183 72 167 88 149 89 137 71 152 71
Line -2064490 false 147 76 171 78
Polygon -6459832 true true 105 90 67 180 82 174 135 105
Circle -7500403 false false 132 90 16
Circle -7500403 false false 138 94 16
Circle -7500403 false false 150 95 16
Circle -7500403 false false 161 21 16
Circle -7500403 false false 154 20 10
Polygon -10899396 true false 239 169 247 177 238 180 229 199 220 186 235 176
Polygon -6459832 true true 166 168 186 167 185 176 182 184 174 193 162 205 148 200 147 188 160 183
Polygon -13791810 true false 123 195 183 195 212 300 169 300 152 224 138 299 92 300
Circle -13345367 true false 149 217 12
Circle -13345367 true false 140 214 12
Circle -13345367 true false 148 222 12
Circle -13345367 true false 150 227 12
Circle -6459832 true true 182 261 10
Circle -6459832 true true 116 216 16

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

knight
false
13
Polygon -7500403 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true false 105 90 60 195 90 210 135 105
Polygon -7500403 true false 195 90 240 195 210 210 165 105
Circle -7500403 true false 110 5 80
Rectangle -7500403 true false 127 79 172 94
Polygon -7500403 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 196 90 151 149
Line -16777216 false 180 195 151 151
Circle -2674135 true false 91 -16 38
Line -16777216 false 104 90 149 149
Line -16777216 false 120 195 149 151
Polygon -1 true false 170 11 140 35 186 63 189 39 180 19
Circle -16777216 true false 164 19 13
Line -16777216 false 141 35 111 44
Line -16777216 false 127 78 174 77
Line -16777216 false 127 91 174 90
Rectangle -16777216 true false 225 128 235 226
Polygon -1184463 true false 232 35 218 64 218 123 210 135 252 134 243 123 244 64 233 37

medusa
false
0
Polygon -10899396 true false 165 212 174 230 205 227 240 257 270 302 255 257 215 215 169 217
Polygon -10899396 true false 135 212 126 230 95 227 60 257 30 302 45 257 85 215 131 217
Polygon -10899396 true false 165 81 135 81 90 165 210 165 165 81
Polygon -14835848 true false 150 19 120 30 120 45 130 66 144 81 127 96 129 113 144 134 136 185 121 195 114 217 120 255 135 270 165 270 180 255 188 218 181 195 165 184 157 134 170 115 173 95 156 81 171 66 181 42 180 30
Polygon -14835848 true false 165 17 174 35 205 32 240 62 270 107 255 62 215 20 169 22
Polygon -10899396 true false 176 62 216 45 252 44 296 77 260 35 217 32 173 49
Polygon -13840069 true false 170 45 200 60 245 75 290 105 248 65 216 56 170 30
Line -7500403 true 120 36 75 45
Line -7500403 true 75 45 90 15
Line -7500403 true 180 35 225 45
Line -7500403 true 225 45 210 15
Polygon -13840069 true false 130 45 100 60 55 75 10 105 52 65 84 56 130 30
Polygon -14835848 true false 124 62 84 45 48 44 4 77 40 35 83 32 127 49
Polygon -10899396 true false 135 17 126 35 95 32 60 62 30 107 45 62 85 20 131 22
Circle -2674135 true false 133 35 12
Circle -2674135 true false 152 36 12
Circle -2674135 true false 138 53 20

neanderthal
false
13
Circle -6459832 true false 110 20 80
Polygon -6459832 true false 108 89 123 194 93 299 108 299 138 299 153 224 168 299 198 299 213 299 183 194 198 89
Rectangle -7500403 true false 135 75 172 94
Polygon -6459832 true false 195 90 254 157 225 180 165 105
Polygon -6459832 true false 105 90 45 154 75 180 135 105
Polygon -16777216 true false 105 60 195 60 180 120 135 120 105 60
Line -6459832 false 150 225 165 225
Polygon -16777216 true false 120 45 105 45 195 45 180 15 120 15 105 45
Polygon -16777216 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -10899396 true false 145 203 137 221 145 221 143 237 150 233 152 246 156 234 159 236 155 226 154 222 170 225 153 204 149 198 146 206
Polygon -6459832 true false 149 72 183 72 167 88 149 89 137 71 152 71
Line -2064490 true 147 76 171 78
Rectangle -955883 true false 225 75 240 285
Polygon -16777216 true false 217 77 232 36 247 77

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

pterodactyl
true
0
Polygon -7500403 true true 150 75 165 75
Polygon -7500403 true true 133 91 148 16 163 91 138 117 163 121 208 91 298 151 238 136 208 136 163 181 178 211 163 226 178 241 163 241 163 226 163 196 148 181 148 196 148 181 133 196 133 241 118 241 133 226 118 211 133 181 88 136 58 136 -2 151 103 91 133 121 158 118 133 91
Circle -7500403 true true 125 113 50
Circle -7500403 true true 139 96 16
Rectangle -7500403 true true 140 89 155 115
Rectangle -7500403 true true 127 218 134 232
Rectangle -7500403 true true 163 219 167 237

robot
false
0
Polygon -7500403 true true 122 162 105 285 137 252 167 252 198 284 182 162
Polygon -1 true false 135 285 105 135 105 105 120 45 136 29 151 28 164 28 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Line -7500403 true 105 105 135 120
Line -7500403 true 135 120 165 120
Line -7500403 true 165 120 195 105
Line -7500403 true 105 135 135 150
Line -7500403 true 135 150 165 150
Line -7500403 true 165 150 195 135
Line -7500403 true 127 64 147 80
Line -7500403 true 170 66 156 81
Circle -7500403 true true 122 67 15
Circle -7500403 true true 162 67 13
Polygon -7500403 true true 106 135 60 109 45 131 49 144 64 187 75 138 107 147
Polygon -7500403 true true 196 132 242 106 257 128 253 141 238 184 227 135 195 144
Polygon -7500403 true true 133 23 217 35 122 39

rocket
true
0
Polygon -7500403 true true 120 165 75 285 135 255 165 255 225 285 180 165
Polygon -1 true false 135 285 105 135 105 105 120 45 135 15 150 0 165 15 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Polygon -7500403 true true 120 45 180 45 165 15 150 0 135 15
Line -7500403 true 105 105 135 120
Line -7500403 true 135 120 165 120
Line -7500403 true 165 120 195 105
Line -7500403 true 105 135 135 150
Line -7500403 true 135 150 165 150
Line -7500403 true 165 150 195 135

skateboarder
false
0
Circle -7500403 true true 102 -23 80
Rectangle -7500403 true true 120 49 165 64
Rectangle -13840069 true false 54 268 264 283
Line -16777216 false 135 165 165 165
Line -16777216 false 135 135 165 135
Line -16777216 false 90 135 120 135
Line -16777216 false 105 120 120 120
Line -16777216 false 180 120 195 120
Line -16777216 false 180 135 210 135
Line -16777216 false 90 150 105 165
Line -16777216 false 225 165 210 180
Line -16777216 false 75 165 90 180
Line -16777216 false 210 150 195 165
Line -16777216 false 180 105 210 180
Line -16777216 false 120 105 90 180
Line -16777216 false 150 135 150 165
Polygon -13840069 true false 98 5 102 19 188 -2 192 -17 171 -15 164 -24 136 -26 109 -22 99 -10
Polygon -7500403 true true 101 61 116 166 86 256 101 271 131 271 146 196 161 271 191 271 206 256 176 166 191 61
Polygon -2674135 true false 56 165 86 180 110 124 116 165 176 165 183 127 206 180 236 165 191 60 161 60 146 75 146 104 131 60 101 60
Polygon -13345367 true false 176 165 116 165 86 255 101 270 131 270 146 195 161 270 191 270 206 255
Circle -16777216 true false 235 275 27
Circle -16777216 true false 53 275 27

spartan
false
13
Rectangle -955883 true false 225 60 240 255
Circle -6459832 true false 110 20 80
Polygon -6459832 true false 108 89 123 194 93 299 108 299 138 299 153 224 168 299 198 299 213 299 183 194 198 89
Rectangle -7500403 true false 135 75 172 94
Polygon -6459832 true false 195 90 254 157 225 180 165 105
Polygon -6459832 true false 105 90 45 154 75 180 135 105
Polygon -16777216 true false 105 60 195 60 178 96 127 94 105 60
Polygon -1184463 true false 120 45 105 45 195 45 180 15 120 15 105 45
Polygon -1184463 true false 120 45 105 75 105 45
Circle -16777216 true false 149 43 12
Circle -16777216 true false 152 46 6
Circle -16777216 true false 172 42 12
Polygon -6459832 true false 149 72 183 72 167 88 149 89 137 71 152 71
Line -16777216 false 147 76 171 78
Polygon -16777216 true false 219 60 232 14 245 61 220 60
Polygon -1184463 true false 105 90 120 90 150 135 180 135 195 90 195 150 180 195 120 195 105 120 105 90
Circle -955883 true false -4 101 127
Circle -16777216 false false 131 93 14
Circle -16777216 false false 149 100 10
Circle -16777216 false false 165 91 13
Circle -16777216 false false 167 104 13
Circle -16777216 false false 153 113 10
Polygon -955883 true false 120 195 180 195 210 255 90 255 120 195
Circle -16777216 false false 6 111 108
Circle -1184463 true false 18 123 85
Circle -2674135 true false 39 144 42

st tiger
false
0
Polygon -1 true false 257 130 272 127 282 133 293 146 293 157 290 165 287 164 287 153 287 144 284 141 276 137 267 136 256 133
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -955883 true false 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -955883 true false -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113
Circle -16777216 true false 59 141 10
Circle -16777216 true false 108 169 7
Circle -16777216 true false 102 139 9
Circle -16777216 true false 128 154 11
Circle -16777216 true false 71 162 8
Circle -16777216 true false 168 139 12
Circle -16777216 true false 149 135 9
Circle -16777216 true false 196 123 12

store
false
0
Rectangle -7500403 true true 30 45 45 240
Rectangle -16777216 false false 30 45 45 165
Rectangle -7500403 true true 15 165 285 255
Rectangle -16777216 true false 120 195 180 255
Line -7500403 true 150 195 150 255
Rectangle -16777216 true false 30 180 105 240
Rectangle -16777216 true false 195 180 270 240
Line -16777216 false 0 165 300 165
Polygon -7500403 true true 0 165 45 135 60 90 240 90 255 135 300 165
Rectangle -7500403 true true 0 0 75 45
Rectangle -16777216 false false 0 0 75 45

student
false
0
Polygon -13791810 true false 135 90 150 105 135 165 150 180 165 165 150 105 165 90
Polygon -2674135 true false 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -955883 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 100 210 130 225 145 165 85 135 63 189
Polygon -13791810 true false 90 210 120 225 135 165 67 130 53 189
Polygon -1 true false 120 224 131 225 124 210
Line -16777216 false 139 168 126 225
Line -16777216 false 140 167 76 136
Polygon -2674135 true false 105 90 60 195 90 210 135 105
Polygon -11221820 true false 166 300 216 302 180 191 139 193 130 228 115 223 112 222 79 300 104 301 138 301 149 226
Circle -16777216 true false 151 25 10
Circle -16777216 true false 174 25 10
Line -16777216 false 153 52 181 59
Circle -6459832 true false 113 13 17
Circle -6459832 true false 124 8 17
Circle -6459832 true false 135 4 17
Circle -6459832 true false 145 4 17
Circle -6459832 true false 156 5 17
Circle -6459832 true false 162 6 17
Circle -6459832 true false 110 23 17
Circle -6459832 true false 121 21 17
Circle -6459832 true false 128 18 17
Circle -6459832 true false 105 32 17

survivor
false
0
Rectangle -7500403 true true 127 79 172 94
Polygon -16777216 true false 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Polygon -6459832 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -16777216 true false 121 90 106 90 181 195 181 165
Line -16777216 false 109 105 139 105
Line -16777216 false 122 125 151 117
Line -16777216 false 138 143 160 134
Line -16777216 false 158 179 181 158
Line -16777216 false 146 160 169 146
Rectangle -16777216 true false 120 193 180 201
Polygon -16777216 true false 122 86 107 74 102 51 105 37 148 56 192 63 189 73 172 88 145 90
Rectangle -16777216 true false 114 187 128 208
Rectangle -16777216 true false 177 187 191 208
Polygon -16777216 true false 122 4 107 16 102 39 105 53 148 34 192 27 189 17 172 2 145 0
Circle -16777216 true false 166 31 13
Polygon -16777216 true false 105 90 60 195 90 210 135 105

terminator
false
0
Polygon -7500403 true true 75 150 90 195 210 195 225 150 255 120 255 45 180 0 120 0 45 45 45 120
Circle -16777216 true false 165 60 60
Circle -16777216 true false 75 60 60
Polygon -7500403 true true 225 195 300 195 285 90 270 105 270 165 180 180
Polygon -7500403 true true 210 210 225 285 195 285 165 165
Polygon -7500403 true true 90 210 75 285 105 285 135 165
Rectangle -7500403 true true 135 165 165 270
Circle -2674135 true false 180 75 30
Circle -2674135 true false 90 75 30
Circle -1 true false 189 82 14
Circle -1 true false 97 82 14
Polygon -7500403 true true 75 195 0 195 15 90 30 105 30 165 120 180
Circle -13345367 true false -4 71 67
Circle -11221820 true false 0 75 60
Line -13345367 false 34 76 26 91
Line -13345367 false 27 88 35 97
Line -13345367 false 18 100 29 111
Line -13345367 false 52 108 27 118
Line -13345367 false 17 86 12 104
Line -13345367 false 26 97 20 110
Line -13345367 false 44 101 37 113
Line -13345367 false 47 91 32 82
Line -13345367 false 12 109 18 124

thug
false
3
Polygon -6459832 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -7500403 true false 60 196 90 211 114 155 120 196 180 196 195 120 255 135 255 105 195 91 165 91 150 106 150 135 135 91 105 91
Circle -6459832 true true 110 5 80
Rectangle -6459832 true true 127 79 172 94
Polygon -13345367 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Line -16777216 false 135 165 165 165
Line -16777216 false 135 135 165 135
Line -16777216 false 90 135 120 135
Line -16777216 false 105 120 120 120
Line -16777216 false 185 108 198 103
Line -16777216 false 196 114 225 108
Line -16777216 false 90 150 105 165
Line -16777216 false 244 111 229 126
Line -16777216 false 75 165 90 180
Line -16777216 false 234 109 219 124
Line -16777216 false 181 100 240 120
Line -16777216 false 120 105 90 180
Line -16777216 false 150 135 150 165
Polygon -16777216 true false 100 30 104 44 189 24 185 10 173 10 166 1 138 -1 111 3 109 28
Rectangle -16777216 true false 247 88 284 98
Rectangle -16777216 true false 254 95 262 115
Line -16777216 false 258 105 270 96

tower
false
15
Rectangle -7500403 true false 135 60 165 90
Rectangle -7500403 true false 180 60 225 90
Rectangle -7500403 true false 90 255 210 300
Line -16777216 false 75 255 225 255
Rectangle -16777216 false false 90 255 210 300
Polygon -7500403 true false 90 255 105 105 195 105 210 255
Polygon -16777216 false false 90 255 105 105 195 105 210 255
Rectangle -7500403 true false 75 90 120 60
Rectangle -7500403 true false 75 84 225 105
Rectangle -7500403 true false 135 90 165 60
Rectangle -7500403 true false 180 90 225 60
Polygon -16777216 false false 90 105 75 105 75 60 120 60 120 84 135 84 135 60 165 60 165 84 179 84 180 60 225 60 225 105
Rectangle -7500403 true false 75 60 120 90

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

troll
false
0
Rectangle -6459832 true false 127 79 172 94
Polygon -10899396 true false 105 90 60 195 90 210 135 105
Polygon -10899396 true false 195 90 240 195 210 210 165 105
Circle -10899396 true false 110 5 80
Polygon -10899396 true false 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -6459832 true false 120 90 105 90 180 195 180 165
Line -6459832 false 109 105 139 105
Line -6459832 false 122 125 151 117
Line -6459832 false 137 143 159 134
Line -6459832 false 158 179 181 158
Line -6459832 false 146 160 169 146
Rectangle -6459832 true false 120 193 180 201
Polygon -16777216 true false 183 90 240 15 247 22 193 90
Rectangle -6459832 true false 116 187 130 208
Rectangle -6459832 true false 177 187 191 208
Circle -955883 true false 163 25 11
Circle -955883 true false 126 25 11
Polygon -955883 true false 153 30 162 44 164 58 162 73 155 71 154 60 141 56 147 47 147 40 153 31
Polygon -6459832 true false 121 198 122 192 125 230 143 224 148 248 166 243 166 229 175 218 181 196
Polygon -16777216 true false 173 14 158 25 158 31 174 23
Polygon -16777216 true false 127 14 142 25 142 31 126 23

ufo side
false
0
Polygon -1 true false 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 195 105 150 105 105 105 60 105 15 120 0 135
Polygon -16777216 false false 105 105 60 105 15 120 0 135 0 150 15 180 60 210 120 225 180 225 240 210 285 180 300 150 300 135 285 120 240 105 210 105
Polygon -7500403 true true 60 131 90 161 135 176 165 176 210 161 240 131 225 101 195 71 150 60 105 71 75 101
Circle -16777216 false false 255 135 30
Circle -16777216 false false 180 180 30
Circle -16777216 false false 90 180 30
Circle -16777216 false false 15 135 30
Circle -7500403 true true 15 135 30
Circle -7500403 true true 90 180 30
Circle -7500403 true true 180 180 30
Circle -7500403 true true 255 135 30
Polygon -16777216 false false 150 59 105 70 75 100 60 130 90 160 135 175 165 175 210 160 240 130 225 100 195 70

viking
false
0
Rectangle -1 true false 123 76 176 95
Polygon -6459832 true false 105 90 60 195 90 210 115 162 184 163 210 210 240 195 195 90
Polygon -6459832 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Circle -1 true false 110 5 80
Line -16777216 false 148 143 150 196
Rectangle -16777216 true false 116 186 182 198
Circle -1 true false 152 143 9
Circle -1 true false 152 166 9
Rectangle -16777216 true false 179 164 183 186
Polygon -955883 true false 180 90 195 90 195 165 195 195 150 195 150 120 180 90
Polygon -10899396 true false 120 90 105 90 105 165 105 195 150 195 150 120 120 90
Polygon -1184463 true false 54 253 54 238 219 73 227 78
Polygon -1184463 true false 266 33 288 61 251 93 243 101 206 63 194 52 244 11
Rectangle -2674135 true false 107 56 107 63
Polygon -2674135 true false 112 52 117 69 118 70 119 71 120 75 121 79 121 81 121 85 128 88 131 89 140 90 145 93 148 97 149 98 156 99 165 96 169 96 173 96 176 94 177 88 178 82 179 80 183 75 186 69 187 63 186 62 185 61 183 58 181 56 179 55 170 55 166 55 160 56 152 56 146 56 141 54 133 53 124 53 120 53 115 54 112 55 110 52
Circle -16777216 true false 162 24 10
Circle -16777216 true false 128 24 10
Line -16777216 false 128 60 170 62

worker
false
13
Polygon -1 true false 124 91 150 165 178 91
Polygon -1 true false 134 91 149 106 134 181 149 196 164 181 149 106 164 91
Polygon -6459832 true false 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -6459832 true false 120 90 105 90 60 195 90 210 116 158 120 195 180 195 184 158 210 210 240 195 195 90 180 90 165 105 150 165 135 105 120 90
Rectangle -2064490 true true 123 76 176 92
Circle -2064490 true true 110 5 80
Polygon -6459832 true false 150 26 110 41 97 29 137 -1 158 6 185 0 201 6 196 23 204 34 180 33
Line -13345367 false 121 90 194 90
Line -16777216 false 120 195 180 195
Circle -16777216 true false 156 38 8
Circle -16777216 true false 175 38 8
Line -16777216 false 151 57 182 58

zombie
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105
Circle -2674135 true false 127 33 13
Circle -2674135 true false 159 33 13
Polygon -2674135 true false 173 104 158 129 157 146 149 154 156 162
Polygon -2674135 true false 113 110 133 125 137 112 123 102 136 102 150 108 149 118 142 134 133 138 121 135 109 123 100 117 117 114 117 109
Polygon -10899396 true false 180 114 191 126 186 131 181 136 180 142 178 147 177 142
Polygon -2674135 true false 140 63 166 61 157 70 140 65
Polygon -955883 true false 135 192 158 200 156 187 144 185 151 181 172 186 171 211 162 215 142 212 131 208 131 199 131 185 133 170 135 193
Polygon -1 true false 199 118 224 143 225 150 225 156
Polygon -1 true false 101 120 76 145 75 152 75 158

@#$#@#$#@
NetLogo 5.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 1.0 0.0
0.0 1 1.0 0.0
0.2 0 1.0 0.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
